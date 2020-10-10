#!/bin/bash

install_k8s(){
    swapoff -a
    modprobe -- ip_vs
    modprobe -- ip_vs_rr
    modprobe -- ip_vs_wrr
    modprobe -- ip_vs_sh
    modprobe -- nf_conntrack_ipv4
    
    sed -i 's/.*swap.*/#&/' /etc/fstab
    kubeadm init --config=init.default.yaml
    mkdir -p $HOME/.kube
    cp  /etc/kubernetes/admin.conf $HOME/.kube/config
    chown $(id -u):$(id -g) $HOME/.kube/config

    cp /etc/kubernetes/admin.conf $HOME/.kube/config
    kubectl apply -f flannel.yaml
    kubectl taint nodes --all node-role.kubernetes.io/master-
    kubectl label nodes 192.168.2.111 bindNode=k8s-master
    kubectl completion bash > /etc/bash_completion.d/kubectl
    kubeadm completion bash > /etc/bash_completion.d/kubeadm
}

reset_k8s() {
    kubeadm reset -f >/dev/null 2>&1
    systemctl stop kubelet
    systemctl stop docker
    rm -rf /var/lib/cni/
    rm -rf /var/lib/kubelet/*
    rm -rf /etc/cni/
    ifconfig flannel.1 down
    ifconfig docker0 down

    # clean cni0, to fix the problem: failed to set bridge addr: "cni0" already has an IP address different from xxx.
  #  while true
  #  do
  #      # if no cni0 bridge, pass.
  #      Cni0Num=`brctl show | cut -f 1 | sed '/^[[:space:]]*$/d' | awk 'NR>1 {print $1}' | grep cni0 | wc -l`
  #      if [[ "$Cni0Num" -eq "0" ]]; then
  #          break;
  #      fi

        ip link set cni0 down
  #      brctl delbr cni0
  #      if [ $? == 0 ]; then
  #          break;
  #      fi
  #      echo "Failed To Delete Bridge Cni0, Sleep 5s And Retry"
  #      sleep 5
  #  done
    ip link delete flannel.1
  #  rm -rf /etc/bigtoe/flags/*

 #   apt-get remove -y kubelet kubeadm kubectl
 #   apt-get autoremove -y

    systemctl start docker
    ipvsadm --clear
}

main(){

   choice=$1

   case ${choice} in
        install)
           install_k8s
     ;;
        reset)
           reset_k8s
     ;;
   esac        


}

main $@
