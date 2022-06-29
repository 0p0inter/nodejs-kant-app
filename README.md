# nodejs-kant-app

##### You need the following installed & configured on your machine
- [Docker](https://docs.docker.com/get-docker/)
- [docker-compose](https://docs.docker.com/compose/install/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Helm](https://helm.sh/docs/intro/install/)
- [ArgoCD](https://argo-cd.readthedocs.io/en/stable/getting_started/)

## Build and run with Docker
```
docker run --rm -p 3888:3888 -it $(docker build -q .)
```

## Build and run with docker-compose
```
docker-compose up 
```

## Install with Helm Chart 

#### Start minikube with adjustment parameters for HPA
```
minikube start --network-plugin=cni --cni=calico ** minikube start --network-plugin=cni --cni=calico --extra-config=controller-manager.horizontal-pod-autoscaler-upscale-delay=1m --extra-config=controller-manager.horizontal-pod-autoscaler-downscale-delay=1m --extra-config=controller-manager.horizontal-pod-autoscaler-sync-period=10s --extra-config=controller-manager.horizontal-pod-autoscaler-downscale-stabilization=1m
```

#### Enable metrics server
```
minikube add-ons enable metrics-server
```

#### Install Helm Chart
```
cd k8s
helm install nodejs-kant-app nodejs-kant-app/ --set service.type=LoadBalancer
```

#### Generate load test for demonstrating HPA
```
chmod +x stess-tester.sh
./stess-tester.sh -a $(echo http://$SERVICE_IP:80) -c 4000
```

#### Deploying ArgoCD Application
```
kubectl apply -f application.yaml
```