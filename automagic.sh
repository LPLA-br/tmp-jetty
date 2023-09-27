#!/bin/bash

# DEPLOY CRU DO CONTAINER
# DA APRESENTAÇÃO SHELL BASH.
# Luiz Paulo - 2023
# nenhum direito reservado.

CNT='jetty-demo'

read -p 'pull da imagem jetty (s|n)>' OPT

if [[ $OPT == 's' || $OPT == 'sim' ]]; then
	docker pull jetty;
fi

docker container stop $CNT ;
docker container rm $CNT ;

docker run --detach --name $CNT --publish 8080:8080 jetty;

docker cp ./estatico $CNT:/var/lib/jetty/webapps/;

docker exec --user root --workdir /var/lib/jetty/webapps $CNT chown -R jetty:jetty ./estatico;

