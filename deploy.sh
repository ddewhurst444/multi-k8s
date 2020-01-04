docker build -t gizzy444/multi-client:latest -t gizzy444/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gizzy444/multi-server:latest -t gizzy444/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gizzy444/multi-worker:latest -t gizzy444/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push gizzy444/multi-client:latest
docker push gizzy444/multi-server:latest
docker push gizzy444/multi-worker:latest

docker push gizzy444/multi-client:$SHA
docker push gizzy444/multi-server:$SHA
docker push gizzy444/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gizzy444/multi-server:$SHA
kubectl set image deployments/client-deployment client=gizzy444/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gizzy444/multi-worker:$SHA