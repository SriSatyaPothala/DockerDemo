## Kubernetes Namespace concepts using Minikube and Kubectl :fire:

This project demonstrates how different namespaces in k8s network with each other by default and how to apply a "Network Policy" to  achieve namespace-level isolation.:smiley:
## Prerequisites
- Minikube 🚜
- Kubectl 🧰
- Docker 	🐳
- CNI plugin that supports 'Network Policy'

## Steps for default networking and  Isolation between Namespaces using Network Policy 	🔐
- minikube start --cni=calico
- kubectl create namespace team-alpha
- kubectl create namespace team-beta
- kubectl run nginx --image=nginx --restart=Never -n team-alpha
- kubectl expose pod nginx --port=80 --target-port=80 --name=nginx-service -n team-alpha 🌐
- kubectl run curlpod --image=alpine --restart=Never -it -n team-beta -- /bin/sh
- inside the pod, curl nginx-service.team-alpha.svc.cluster.local ✅
- Now, apply Network Policy using deny-external.yaml
- kubectl label namespace team-alpha name=team-alpha
- kubectl apply -f deny-external.yaml
- 🔁 Re-test from team-beta
- ❌ This time, the connection should fail — NetworkPolicy is blocking ingress from team-beta.



📝 Notes
🧱 Namespaces in Kubernetes follow a flat design and by default, they can communicate with each other unless blocked by a Network Policy 🔐.
🔄 For example, a Pod in namespace1 (if exposed via a 🌐 Service) can be accessed by a Pod in namespace2.

🗂️ Namespaces provide logical isolation and help you group related resources like:

📦 Pods

🌐 Services

🚀 Deployments

⚙️ ConfigMaps

🔑 Secrets

🌐 Each namespace has its own DNS subdomain, which enables service discovery:

Intra-namespace access: curl nginx-service

Cross-namespace access: curl nginx-service2.demo-namespace2.svc.cluster.local

🚫 Isolation between namespaces can be achieved using:

🔐 Network Policies

🛡️ RBAC (Role-Based Access Control)