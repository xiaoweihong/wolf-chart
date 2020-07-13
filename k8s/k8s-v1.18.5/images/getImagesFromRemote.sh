echo ""
echo "=========================================================="
echo "Pull Kubernetes for amd64 v1.18.5 Images from docker.io ......"
echo "=========================================================="
echo ""

MY_REGISTRY=mirrorgcrio

## 拉取镜像
docker pull ${MY_REGISTRY}/kube-apiserver-amd64:v1.18.5
docker pull ${MY_REGISTRY}/kube-controller-manager-amd64:v1.18.5
docker pull ${MY_REGISTRY}/kube-scheduler-amd64:v1.18.5
docker pull ${MY_REGISTRY}/kube-proxy-amd64:v1.18.5
docker pull ${MY_REGISTRY}/etcd-amd64:3.4.3-0
docker pull ${MY_REGISTRY}/pause-amd64:3.2

# 注意，coredns的仓库可以直接使用官方的：
docker pull coredns/coredns:1.6.7

## 添加Tag
docker tag ${MY_REGISTRY}/kube-apiserver-amd64:v1.18.5 k8s.gcr.io/kube-apiserver:v1.18.5
docker tag ${MY_REGISTRY}/kube-scheduler-amd64:v1.18.5 k8s.gcr.io/kube-scheduler:v1.18.5
docker tag ${MY_REGISTRY}/kube-controller-manager-amd64:v1.18.5 k8s.gcr.io/kube-controller-manager:v1.18.5
docker tag ${MY_REGISTRY}/kube-proxy-amd64:v1.18.5 k8s.gcr.io/kube-proxy:v1.18.5
docker tag ${MY_REGISTRY}/etcd-amd64:3.4.3-0 k8s.gcr.io/etcd:3.4.3-0
docker tag ${MY_REGISTRY}/pause-amd64:3.2 k8s.gcr.io/pause:3.2

#codredns也要改tag:
docker tag coredns/coredns:1.6.7 k8s.gcr.io/coredns:1.6.7

echo ""
echo "=========================================================="
echo "Pull Kubernetes for amd64 v1.18.5 Images FINISHED."
echo "into docker.io/mirrorgcrio, "
echo " by openthings@https://my.oschina.net/u/2306127."
echo "=========================================================="

echo ""

