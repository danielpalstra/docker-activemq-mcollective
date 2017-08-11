# Swarm setup

Maak een Docker Swarm aan om de ActiveMQ brokers met elkaar te laten communiceren.

Gebruikte docs:
* [Swarm cluster opzetten](https://docs.docker.com/engine/swarm/swarm-tutorial/)
* [Compose icm swarm](https://codefresh.io/blog/deploy-docker-compose-v3-swarm-mode-cluster/)
* [Deploy services](http://blog.arungupta.me/deploy-docker-compose-services-swarm/)

## Docker Swarm manager

```shell
docker swarm init --advertise-addr 10.9.27.2
```

output:

```
docker swarm join \
--token SWMTKN-1-1dv8r23jrzca8hcwss8go2geu6qermtb9qagerwu5v41lhh77l-3z9aolbdhr9mi2kapdri2p8yl \
10.9.27.2:2377
```

### Nodes beheren

Aantal nodes opvragen

```shell
docker node ls
```


## Docker Swarm workers

Voeg workers toe aan de swarm door op elke andere docker node het volgende commando uit te voeren. 

```
    docker swarm join \
    --token SWMTKN-1-1dv8r23jrzca8hcwss8go2geu6qermtb9qagerwu5v41lhh77l-3z9aolbdhr9mi2kapdri2p8yl \
    10.9.27.2:2377
```

## Apps deployen

Clone de git repo

```shell
git clone http://git.k94.kvk.nl/zmm-infra/puppet-activemq.git activemq
```

Deploy de stack

```shell
docker stack deploy --with-registry-auth --compose-file=docker-compose.swarm.yml activemq
```