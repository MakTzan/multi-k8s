docker build -t maktzan/multi-client:latest -t maktzan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maktzan/multi-server:latest -t maktzan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maktzan/multi-worker:latest -t maktzan/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push maktzan/multi-client:latest
docker push maktzan/multi-server:latest
docker push maktzan/multi-worker:latest

docker push maktzan/multi-client:$SHA
docker push maktzan/multi-server:$SHA
docker push maktzan/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maktzan/multi-server:$SHA
kubectl set image deployments/client-deployment client=maktzan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=maktzan/multi-worker:$SHA