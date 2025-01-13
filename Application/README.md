# Install Application onto Kubernetes
The app testing with is from https://github.com/wgsaxton/ps_go_build_dist_apps

Install the helm chart for the app:
```
helm install dev --version 0.2.0 --namespace gstest --create-namespace oci://ghcr.io/wgsaxton/gradebook
```
