#!/bin/bash

# 1. Start Minikube with a limit that fits your Docker Desktop settings
echo "Starting Minikube cluster..."
minikube start --memory 3000 --cpus 2 --driver=docker

# 2. Apply Storage and Configuration (Referencing the k8s folder)
echo "Applying PV, PVC, and ConfigMaps..."
kubectl apply -f k8s/mysql-pv.yaml
kubectl apply -f k8s/mysql-pvc.yaml
kubectl apply -f k8s/mysql-configmap.yaml

# 3. Apply Networking
echo "Applying Service definitions..."
kubectl apply -f k8s/services.yaml

# 4. Apply Application Deployments
echo "Deploying Jenkins, Nexus, MySQL, and Webapp..."
kubectl apply -f k8s/jenkins-deployment.yaml
kubectl apply -f k8s/nexus-deployment.yaml
kubectl apply -f k8s/mysql-deployment.yaml
kubectl apply -f k8s/webapp-deployment.yaml

# 5. Wait for the Webapp to be ready
echo "Waiting for webapp deployment to complete..."
kubectl rollout status deployment/springboot-webapp --timeout=120s

# 6. Final Status Check (Required for full points)
echo "------------------------------------------------"
echo "FINAL SYSTEM CHECK"
echo "------------------------------------------------"

echo "ConfigMaps:"
kubectl get configmap

echo "Deployments:"
kubectl get deployments

echo "Services:"
kubectl get services

echo "Pods:"
kubectl get pods

echo "------------------------------------------------"
echo "Script finished."
