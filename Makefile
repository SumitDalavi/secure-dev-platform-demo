.PHONY: cluster-up bootstrap build-images load-images webhook-deploy operator-deploy rotation-deploy policy-apply demo cluster-down up down

up: cluster-up build-images load-images bootstrap webhook-deploy operator-deploy rotation-deploy policy-apply
	@echo "Cluster is up and operators are deployed."

down: cluster-down
cluster-up:
	kind create cluster --config cluster/kind-config.yaml --name platform-demo

bootstrap:
	bash cluster/bootstrap.sh

build-images:
	docker build -t k8s-admission-webhook:local ../k8s-admission-webhook-from-scratch
	docker build -t golden-path-provisioner:local ../k8s-golden-path-provisioner
	docker build -t secret-rotation-operator:local ../k8s-secret-rotation-operator

load-images: build-images
	kind load docker-image k8s-admission-webhook:local --name platform-demo
	kind load docker-image golden-path-provisioner:local --name platform-demo
	kind load docker-image secret-rotation-operator:local --name platform-demo

webhook-deploy:
	kubectl apply -f ../k8s-admission-webhook-from-scratch/k8s/

operator-deploy:
	helm upgrade --install golden-path ../k8s-golden-path-provisioner/helm/ \
		--set image.repository=golden-path-provisioner \
		--set image.tag=local \
		--set image.pullPolicy=Never

rotation-deploy:
	kubectl apply -f ../k8s-secret-rotation-operator/config/

policy-apply:
	kubectl apply -f manifests/kyverno-policy.yaml

demo:
	bash demo/run_demo.sh

cluster-down:
	kind delete cluster --name platform-demo
