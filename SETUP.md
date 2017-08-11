# Opzetten ActiveMQ cluster

Onderstaande stappen moeten worden gevolgt om kvk specifieke (puppet) configuratie toe te voegen aan het ActiveMQ cluster. De setup is neer gezet op basis van de volgende [documentatie](https://docs.puppet.com/mcollective/deploy/middleware/activemq_keystores.html)

*Let op dat de gebruikte wachtwoorden voor de keystores altijd gelijk zijn!*

Keystores worden apart aangemaakt voor de master en de slave(s).

## Certificaten voor ActiveMQ aanmaken

Voer de volgende acties uit op de puppetmaster (MoM). Browse naar de ssl directory.

```shell
cd /etc/puppetlabs/puppet/ssl
```

Genereer een nieuw certificaat en onderteken deze met de CA van de puppetmaster.

ActiveMQ Master

```shell
puppet certificate generate --ca-location remote --dns-alt-names master activemq-master.core.k94.kvk.nl
puppet cert --allow-dns-alt-names sign activemq-master.core.k94.kvk.nl
```

ActiveMQ Slave
```
puppet certificate generate --ca-location remote --dns-alt-names slave activemq-slave.core.k94.kvk.nl
puppet cert --allow-dns-alt-names sign activemq-slave.core.k94.kvk.nl
```

Creer een P12 keystore van de gegenereerde certificaten.

Master

```shell
cat private_keys/activemq-master.core.k94.kvk.nl.pem ca/signed/activemq-master.core.k94.kvk.nl.pem > /tmp/temp-master.pem
openssl pkcs12 -export -in /tmp/temp-master.pem -out /tmp/activemq-master.p12 -name activemq-master.core.k94.kvk.nl
```

Slave

```shell
cat private_keys/activemq-slave.core.k94.kvk.nl.pem ca/signed/activemq-slave.core.k94.kvk.nl.pem > /tmp/temp-slave.pem
openssl pkcs12 -export -in /tmp/temp-slave.pem -out /tmp/activemq-slave.p12 -name activemq-slave.core.k94.kvk.nl
```

## Keystores voor ActiveMQ aanmaken

Voer de volgende acties lokaal uit. Haal de p12 keystores op van de puppet master en voeg ze toe aan de configuratie directory van activemq. Converteer de keystore naar het juiste formaat.

Master

```shell
keytool -importkeystore  -destkeystore broker.ks -srckeystore activemq-master.p12 -srcstoretype PKCS12 -alias activemq-master.core.k94.kvk.nl
```

Slave

```shell
keytool -importkeystore  -destkeystore broker.ks -srckeystore activemq-slave.p12 -srcstoretype PKCS12 -alias activemq-slave.core.k94.kvk.nl
```
