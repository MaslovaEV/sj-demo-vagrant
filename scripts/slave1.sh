#!/usr/bin/env bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv E56151BF
echo "deb http://repos.mesosphere.com/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/mesosphere.list

sudo apt-get update

sudo apt-get -y install mesos

echo "zk://192.168.50.51:2181/mesos" | sudo tee /etc/mesos/zk

sudo service zookeeper stop
sudo sh -c "echo manual > /etc/init/zookeeper.override"
sudo service mesos-master stop
sudo sh -c "echo manual > /etc/init/mesos-master.override"

sudo touch /etc/mesos-slave/containerizers
echo "docker,mesos" | sudo tee /etc/mesos-slave/containerizers
echo 0.0.0.0 | sudo tee /etc/mesos-slave/ip
echo 192.168.50.52 | sudo tee /etc/mesos-slave/advertise_ip
echo 192.168.50.52 | sudo tee /etc/mesos-slave/hostname
sudo touch /etc/mesos-slave/resources
echo "cpus:2;mem:4096;disk:1024;ports:[8888-8888];ports:[9092-9092];ports:[7203-7203];ports:[31071-31071]" | sudo tee /etc/mesos-slave/resources
sudo service mesos-slave restart

#Starting elasticsearch on docker
#sudo docker run -d --restart=always --name elasticsearch -p 9200:9200 -p 9300:9300 -e http.host=0.0.0.0 -e xpack.security.enabled=false -e transport.host=0.0.0.0 -e cluster.name=elasticsearch docker.elastic.co/elasticsearch/elasticsearch:5.5.1
#sudo docker run -d --restart=always --name kibana -p 5601:5601 -e ELASTICSEARCH_URL=http://192.168.50.52:9200 -v kibana_data:/data kibana:5.5.1