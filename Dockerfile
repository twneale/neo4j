## Neo4J dependency: dockerfile/java
## get java from trusted build
from dockerfile/java
maintainer Tiago Pires, tiago-a-pires@ptinovacao.pt

## install neo4j according to http://www.neo4j.org/download/linux
# Import neo4j signing key
run wget -O - http://debian.neo4j.org/neotechnology.gpg.key | apt-key add - 
# Create an apt sources.list file
run echo 'deb http://debian.neo4j.org/repo stable/' > /etc/apt/sources.list.d/neo4j.list
# Find out about the files in neo4j repo ; install neo4j community edition
run apt-get update ; apt-get install neo4j -y

## add launcher and set execute property
add launch.sh /
run chmod +x /launch.sh

## clean sources
run apt-get clean

# enable shell server on all network interfaces
run echo "remote_shell_host=0.0.0.0" >> /var/lib/neo4j/conf/neo4j.properties

# expose REST and shell server ports
expose 7474
expose 1337

workdir /

## entrypoint
cmd ["/bin/bash", "-c", "/launch.sh"]
