kubectl config set-cluster kubernetes --server="$1" --certificate-authority="$3" --embed-certs=true
kubectl config set-credentials kubernetes-admin --token="$2"
kubectl config set-context kubernetes-admin --cluster=kubernetes --user=kubernetes-admin --namespace=default
kubectl config use-context kubernetes-admin
