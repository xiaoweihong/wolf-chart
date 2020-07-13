#!/bin/bash



find k8s/k8s-v1.18.5/images/ -name *.img|xargs -i docker load -i {};

kubectl create ns wolf
kubectl create cm basenv --from-env-file=env/env -n wolf
helm install wolf .
