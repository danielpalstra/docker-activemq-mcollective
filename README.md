# ActiveMQ

Testing a network of brokers of ActiveMQ with MCollective. Docker is used to test the scale of MCollective server instances. The MCollective server connects to the slave(s). Mco client connects to the master to make sure all connected agents receive the messages.

## Compose files

Compose files are split so building and local testing is seperated from running the activemq broker network. 

`docker-compose.yml`

Contains the "master/slave" activemq broker network. Also contains MCollective to test ActiveMQ at scale. The compose file can be used in Rancher as well.

`development.yml`

Contains the definitions to build the activemq and mcollective images so they can be used in any orchestration tool (like Rancher). `development.yml` can also be used to test/ debug locally since it mounts the config files.

`consumer.yml`

Contains a ruby stomp client to test the network of activemq brokers

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
docker-compose up --scale mcollective=10 -d mcollective
```

Run another `mco ping`

```shell
docker-compose run --entrypoint=mco mcollective ping
```

## Building

```shell
dc -f docker-compose.yml -f development.yml build master slave mcollective
```

## References

* Inspiration for ActiveMQ Docker image: https://github.com/rmohr/docker-activemq
* Samples for ActiveMQ Network of Brokers setup https://github.com/apache/activemq/blob/master/assembly/src/release/examples/conf/activemq-static-network-broker2.xml
* Network of brokers configuration http://activemq.apache.org/networks-of-brokers.html
* Description on setting up the right connections within a network of brokers: https://access.redhat.com/documentation/en-US/Fuse_ESB_Enterprise/7.1/html/Using_Networks_of_Brokers/files/FMQNetworksConnectors.html