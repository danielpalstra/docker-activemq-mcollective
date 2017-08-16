# Todo

Stappen nog te doen. 

* Authenticatie aanzetten voor ActiveMQ
* Wachtwoorden wijzigen voor standaard users
* Monitoring ontwerpen (Jolokia gebruiken)
* Fixed ip regelen voor een Docker Swarm manager (optioneel?)

[16-08-17]

* De slave nodes hebben nu een A record welke refereert aan de DHCP adressen van de nodes. Uitzoeken hoe dit beter kan. 
* De master node heeft een CNAME record naar de hostname van de node. 
