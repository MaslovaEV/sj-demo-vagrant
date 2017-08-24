### SJ-Platform Deployment via Vagrant

**Required**:

At least 7GB free ram.

VT-x must be enabled in bios.

To determine if cpu vt extensions are enabled in bios, do following:

1) Install cpu-checker:
```
$ sudo apt-get update
$ sudo apt-get install cpu-checker
```
2) Then check:
```
$ kvm-ok
```
3) If the CPU is enabled, you should see something like:
```
INFO: /dev/kvm exists
KVM acceleration can be used
```
4) Otherwise, you might see something like:
```
INFO: /dev/kvm does not exist
HINT:   sudo modprobe kvm_intel
INFO: Your CPU supports KVM extensions
INFO: KVM (vmx) is disabled by your BIOS
HINT: Enter your BIOS setup and enable Virtualization Technology (VT),
      and then hard poweroff/poweron your system
KVM acceleration can NOT be used
```
### Deployment

At first install vagrant and virtualbox. You can do it by official instruction: https://www.vagrantup.com/docs/installation/ and https://www.virtualbox.org/wiki/Downloads

Checked with:

- Vagrant 1.9.7
- VirtualBox 5.0.40
- Ubuntu 16.04

Clone git repository:
```
git clone https://github.com/bwsw/sj-demo-vagrant.git
cd sj-demo-vagrant
```

Launch vagrant:
```
vagrant up
```
It takes up to half an hour, 8GB mem and 7 CPUs.

At the end of deploying you can see urls on all services.

### Description
Vagrant create five ubuntu/xenial64 VMs with specific parameters: \
Master VM - 2 CPUs, 1GB memory \
Slave1 VM - 2 CPUs, 3GB memory \
Slave2 VM - 1 CPUs, 2GB memory \
Storage VM - 1 CPUs, 512MB memory \
Executor VM - 1 CPUs, 200MB memory \

List of used ports: \
8080 - Marathon \
5050 - Master \
5051 - Agent \
8888 - SJ Rest \
27017 - Mongo \
2181 - Zookeeper \
9200,9300 - Elasticsearch \
5601 - Kibana \
9092,7203 - Kafka \

To destroy vagrant use:
```
vagrant destroy
```
