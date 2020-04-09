docker build -t kivo/udemy-multi-client:latest -t kivo/udemy-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kivo/udemy-multi-worker:latest -t kivo/udemy-multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t kivo/udemy-multi-server:latest -t kivo/udemy-multi-server:$SHA -f ./server/Dockerfile ./server

docker push kivo/udemy-multi-client:latest
docker push kivo/udemy-multi-worker:latest
docker push kivo/udemy-multi-server:latest

docker push kivo/udemy-multi-client:$SHA
docker push kivo/udemy-multi-worker:$SHA
docker push kivo/udemy-multi-server:$SHA

kubectl apply -f k8s

kubectl set image deployment/client-deployment client=kivo/udemy-multi-client:$SHA
kubectl set image deployment/worker-deployment worker=kivo/udemy-multi-worker:$SHA
kubectl set image deployment/server-deployment server=kivo/udemy-multi-server:$SHA