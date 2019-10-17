#prima fase 'builder'
FROM node:alpine as builder 
WORKDIR '/app'
#copia del file con le dipendenze
COPY ./package.json ./
#installa dipendenze
RUN npm install
#copia di tutto il resto dei files
COPY . .
#build degli assets per la produzione
#tutti i file buldati vanno nella cartella build
RUN npm run build

#seconda fase
FROM nginx
#cambio della porta listen di default
#vedi file nginx/deault.conf: qui viene configurata la porta 3000 ed esposto il path dei file html
#che vengono copiati qui in fondo
EXPOSE 3000
#override del file di configurazione
COPY ./nginx/deafult.conf /etc/nginx/conf.d/default.conf
#copia degli assets buildati nella prima fase 'builder' nella cartella html di nginx
COPY --from=builder /app/build /usr/share/nginx/html
