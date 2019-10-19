#buld delle immagini docker con tag, file e contesto
#applichiamo due tag, il default (latest) e uno con la firma da utilizzare come identificativo della versione
docker build -t gabrielescotti/multi-client:latest -t gabrielescotti/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gabrielescotti/multi-server:latest -t gabrielescotti/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gabrielescotti/multi-worker:latest -t gabrielescotti/multi-worker:$SHA -f ./worker/Dockerfile ./worker
#push delle immagini su docker hub, ci siamo già loggati in precedenza (vedi file .travis.yml)
docker push gabrielescotti/multi-client:latest
docker push gabrielescotti/multi-client:$SHA
docker push gabrielescotti/nulti-server:latest
docker push gabrielescotti/nulti-server:$SHA
docker push gabrielescotti/multi-worker:latest
docker push gabrielescotti/multi-worker:$SHA
#applichiamo tutte le configurazioni di kubernetes presenti nella cartella k8s
#abbiamo già installato kubectl per cui possiamo utilizzare il tool (vedi file .travis.yml)
kubectl apply -f k8s
#dobbiamo specificare di utilizzare l'ultima versione delle immagini (utilizzo l'identificativo della versione creato prima)
kubectl set image deployments/server-deployment server=gabrielescotti/multi-server:$SHA
kubectl set image deployments/client-deployment client=gabrielescotti/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gabrielescotti/multi-worker:$SHA