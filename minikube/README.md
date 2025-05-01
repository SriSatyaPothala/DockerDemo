## Kubernetes Namespace concepts using Minikube and Kubectl :fire:

This project demonstrates how different namespaces in k8s network with each other by default and how to apply a "Network Policy" to  achieve namespace-level isolation.:smiley:
## Prerequisites
- Minikube
- Kubectl
- Docker
- CNI plugin that supports 'Network Policy'
## Steps
- start minikube
- create namespaces
- create one nginx pod in demo-namespace and expose using nginx-service in the same namespace
- create a pod in another demo-namespace2 which uses a curl image and open it using interactive terminal
- Try to curl into the nginx-service using cross-namespace dns (nginx-service.demo-namespace.svc.cluster.local)
- Access the nginx-service :white_check_mark:

## Isolation between Namespaces using Network Policy



### Notes
- Namespaces in kubernetes by default follows flat design and they are able to communicate with one another as long as there are no specific network policies preventing access.
- For instance, a pod in namespace1 (if exposed using a service)can communicate with another pod in namespace2.
- So namespaces provides logical isolation and helps you group pods, services, deployments, configMaps, secrets.
- Each namespace has its own DNS subdomain, which helps resolve service names within and across namespaces. ex: curl nginx-service (intra-namespace service) | curl nginx-service2.demo-namespace2.svc.cluster.local (cross-namespace access)
- Isolation between namespaces can be achieved using Network Policies, using RBAC. Advanced CNI plugins can support namespace-level firewalls.