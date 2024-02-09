docker build -t jigarshah088/multi-client-k8s:latest -t jigarshah088/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t jigarshah088/multi-server-k8s:latest -t jigarshah088/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t jigarshah088/multi-worker-k8s:latest -t jigarshah088/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push jigarshah088/multi-client-k8s:latest
docker push jigarshah088/multi-server-k8s:latest
docker push jigarshah088/multi-worker-k8s:latest

docker push jigarshah088/multi-client-k8s:$SHA
docker push jigarshah088/multi-server-k8s:$SHA
docker push jigarshah088/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jigarshah088/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=jigarshah088/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=jigarshah088/multi-worker-k8s:$SHA