List the helm chart
root@XXXXX:~# helm list 
NAME               	REVISION	UPDATED                 	STATUS  	CHART                	NAMESPACE  
glance             	1       	Thu May  3 17:02:03 2018	DEPLOYED	glance-0.1.0         	openstack  
heat               	1       	Thu May  3 16:56:25 2018	DEPLOYED	heat-0.1.0           	openstack  
horizon            	1       	Thu May  3 16:58:49 2018	DEPLOYED	horizon-0.1.0        	openstack  
ingress-kube-system	2       	Fri May  4 13:11:06 2018	DEPLOYED	ingress-0.1.0        	kube-system
ingress-openstack  	2       	Fri May  4 13:11:07 2018	DEPLOYED	ingress-0.1.0        	openstack  
keystone           	1       	Thu May  3 15:41:01 2018	DEPLOYED	keystone-0.1.0       	openstack  
kube-dns           	1       	Thu May  3 14:50:49 2018	DEPLOYED	kube-dns-0.1.0       	kube-system
libvirt            	1       	Fri May  4 01:36:05 2018	DEPLOYED	libvirt-0.1.0        	openstack  
mariadb            	1       	Thu May  3 15:25:36 2018	DEPLOYED	mariadb-0.1.0        	openstack  
memcached          	1       	Thu May  3 15:33:55 2018	DEPLOYED	memcached-0.1.0      	openstack  
neutron            	1       	Fri May  4 01:43:28 2018	DEPLOYED	neutron-0.1.0        	openstack  
nfs-provisioner    	1       	Thu May  3 15:23:37 2018	DEPLOYED	nfs-provisioner-0.1.0	nfs        
nova               	1       	Fri May  4 01:43:25 2018	DEPLOYED	nova-0.1.0           	openstack  
rabbitmq           	1       	Thu May  3 15:32:44 2018	DEPLOYED	rabbitmq-0.1.0       	openstack  
tiller             	1       	Thu May  3 14:51:04 2018	DEPLOYED	tiller-0.1.0         	kube-system

Removing the helm chart:-
========================
set -X; for i in $(helm list | awk '{print $1}'); do helm delete $i --purge; done
release "heat" deleted
release "horizon" deleted
release "ingress-kube-system" deleted
release "ingress-openstack" deleted
release "keystone" deleted
release "kube-dns" deleted
release "libvirt" deleted
release "mariadb" deleted
release "memcached" deleted
release "neutron" deleted
