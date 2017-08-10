# ActiveMQ

Bron voor ActiveMQ Docker image: https://github.com/rmohr/docker-activemq
Voorbeeld voor network of brokers configuratie: https://github.com/apache/activemq/blob/master/assembly/src/release/examples/conf/activemq-static-network-broker2.xml
Network of brokers configuratie: http://activemq.apache.org/networks-of-brokers.html

## Compose files

Compsoe files are split so building and local testing is seperated from running the activemq broker network. 

`docker-compose.yml`

Contains the "master/slave" activemq broker network. Can be used in Rancher as well.

`development.yml`

Contains the definitions to build the activemq and mcollective images so they can be used in any orchestration tool (like Rancher). `development.yml` can also be used to test/ debug locally since it mounts the config files.

`clients.yml`

Contains MCollective to test the network of activemq brokers

## Testing

Start the cluster and one mco instance

```shell
docker-compose up
```

Run `mco ping` 

```shell
docker-compose run --entrypoint=mco mcollective ping
```

Scale the mco instances

```shell
docker-compose up --scale mcollective=10 -d
```

Run another `mco ping`

```shell
docker-compose run --entrypoint=mco mcollective ping
```

## Building

```shell
dc -f docker-compose.yml -f development.yml build
```