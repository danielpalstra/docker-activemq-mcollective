FROM puppet/puppet-agent

COPY * /etc/puppetlabs/mcollective/

ENTRYPOINT [ "/opt/puppetlabs/puppet/bin/mcollectived" ]
CMD [ "--help" ]