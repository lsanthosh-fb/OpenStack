**Ubunut VM Instantation on Openstack**

**List the IMAGE on Cloud**

```
[xxxx@director ~]$ openstack image list 
+--------------------------------------+-------------------------------------------------+--------+
| ID                                   | Name                                            | Status |
+--------------------------------------+-------------------------------------------------+--------+
| 65ce7343-8b76-4a39-bcc2-f6c4b6261d51 | RedHat                                          | active |
| 9b200832-0a85-4863-b63e-0c9ee0a0da98 | Ubuntu_Xenial                                   | active |
| dbdd504d-09f5-4481-9eed-d096558d38d0 | Windows-Server-2012-R2-Std-Eval                 | active |
| 25e64422-8df0-4366-a99f-2915033f53ee | cirros                                          | active |
+--------------------------------------+-------------------------------------------------+--------+
[xxxx@director ~]$ 

```
```
[xxxx@director ~]$ openstack image list  | grep -i ubuntu
| 9b200832-0a85-4863-b63e-0c9ee0a0da98 | Ubuntu_Xenial                                   | active |
[xxxx@director ~]$ 
```
**Filter the Network that you wanted to attach with VM**

```
[xxxx@director ~]$ openstack network list | grep -i provider
| 96f441d8-0905-4adb-aba4-3820cb4a8377 | CLOUD1-PUB-PROVIDER-NET | 96bcfdea-277c-41bc-9757-6fefe6dcd7d8 |
| ae3f3381-8584-4356-b461-3f76349f7ad0 | CLOUD1-PRI-PROVIDER-NET | 73bbfc12-0b50-4bd0-8d16-9aef60ec8129 |
[xxxx@director ~]$ 
[xxxx@director ~]$ openstack network list | grep -i OAM
| 771f946f-e0cd-4ccc-beac-52cdf1d80e67 | CLOUD1-OAM-NET          | 9a3f1f48-1397-4fe2-bb92-a3faafbc8d4c |
[xxxx@director ~]$ 

```

**List the Flavour**

```
[xxxxx@director ~]$ openstack flavor list 
+--------------------------------------+---------------+-------+------+-----------+-------+-----------+
| ID                                   | Name          |   RAM | Disk | Ephemeral | VCPUs | Is Public |
+--------------------------------------+---------------+-------+------+-----------+-------+-----------+
| 0c73ed8e-4773-4751-86d7-bdcefbe974b2 | SevOne_Flavor |  4096 |  150 |         0 |     2 | True      |
| 172f9de4-5adf-41ac-b74c-2fec9f4eb5ce | 8c8r120d      |  8192 |  120 |         0 |     8 | True      |
| 189c94c5-efed-468e-bfe3-08c9117a42e2 | 8c8r200d      |  8192 |  200 |         0 |     8 | True      |
| 222e757f-6601-4cee-bc05-6eeb8936a811 | 4c9r21d       |  9216 |   21 |         0 |     4 | True      |
| 31355076-9465-4f28-9d43-e86ecae14bf6 | 8c25r150d     | 25600 |  150 |         0 |     8 | True      |
| 463643c6-98eb-4143-9a28-c1e1b99b3197 | 4c9r210d      |  9216 |  210 |         0 |     4 | True      |
| 47e1d835-a262-483c-bbaa-9a3293f4f786 | 4c8r40d       |  8096 |   40 |         0 |     4 | True      |
| 70b4e619-f2f4-4c33-b1ba-7fdfbdc32c46 | 4c8r60d       |  8192 |   60 |         0 |     4 | True      |
| 7ea9bf9e-0ba3-4ec2-bb9f-3a09f07a5635 | 12c9r21d      |  9216 |   21 |         0 |    12 | True      |
| 8a2eabce-91f7-4532-a751-71bae5930ba1 | Affirmed_MCM  | 32768 |  112 |         0 |     8 | True      |
| 8bfdb918-c35d-43ce-af5d-0904522d800d | Affirmed_CSM  | 32768 |   50 |         0 |     8 | True      |
| 9afbff33-d62b-4523-960d-aeb11510d89e | 8c8r50d       |  8192 |   50 |         0 |     8 | True      |
| 9ea56541-d160-445f-b9e7-67d9e215e974 | Affirmed_SSM  | 32768 |   50 |         0 |     8 | True      |
| a2cd9e26-665e-4dbe-93c5-978a1a301976 | 4c10r150d     | 10240 |  150 |         0 |     4 | True      |
| a82d8aa3-7011-40c5-a4b0-f80b60286706 | 2c4r150d      |  4096 |  150 |         0 |     2 | True      |
| b23cd67e-22df-4ba4-8d66-0ef46fdebe79 | 4c20r150d     | 20480 |  150 |         0 |     4 | True      |
| b631e934-2cd5-4895-9628-51a8621cdc57 | 4c8r30d       |  8096 |   30 |         0 |     4 | True      |
| de3a29de-f63f-408f-a159-2c8037150033 | 17c9r21d      |  9216 |   21 |         0 |    17 | True      |
| eb7d9d02-e513-44bb-9b57-7b61ff1c725f | 16c32r550d    | 32768 |  550 |         0 |    16 | True      |
| fa772a50-ea9b-44de-ab99-519fcba1bed0 | 8c28r50d      | 28672 |   50 |         0 |     8 | True      |
+--------------------------------------+---------------+-------+------+-----------+-------+-----------+
```
Creating the VM with dependent arugemnts
=========================================
```
[xxxx@director ~]$ nova boot --flavor 8c8r200d --image Ubuntu_Xenial  --nic net-id=771f946f-e0cd-4ccc-beac-52cdf1d80e67  --nic net-id=ae3f3381-8584-4356-b461-3f76349f7ad0 --security-group default Ubuntu_Dock
+--------------------------------------+------------------------------------------------------+
| Property                             | Value                                                |
+--------------------------------------+------------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                               |
| OS-EXT-AZ:availability_zone          |                                                      |
| OS-EXT-SRV-ATTR:host                 | -                                                    |
| OS-EXT-SRV-ATTR:hostname             | ubuntu-dock                                          |
| OS-EXT-SRV-ATTR:hypervisor_hostname  | -                                                    |
| OS-EXT-SRV-ATTR:instance_name        |                                                      |
| OS-EXT-SRV-ATTR:kernel_id            |                                                      |
| OS-EXT-SRV-ATTR:launch_index         | 0                                                    |
| OS-EXT-SRV-ATTR:ramdisk_id           |                                                      |
| OS-EXT-SRV-ATTR:reservation_id       | r-7yz1b5vq                                           |
| OS-EXT-SRV-ATTR:root_device_name     | -                                                    |
| OS-EXT-SRV-ATTR:user_data            | -                                                    |
| OS-EXT-STS:power_state               | 0                                                    |
| OS-EXT-STS:task_state                | scheduling                                           |
| OS-EXT-STS:vm_state                  | building                                             |
| OS-SRV-USG:launched_at               | -                                                    |
| OS-SRV-USG:terminated_at             | -                                                    |
| accessIPv4                           |                                                      |
| accessIPv6                           |                                                      |
| adminPass                            | PJKE4rrXXrzt                                         |
| config_drive                         |                                                      |
| created                              | 2018-03-01T19:18:46Z                                 |
| description                          | -                                                    |
| flavor                               | 8c8r200d (189c94c5-efed-468e-bfe3-08c9117a42e2)      |
| hostId                               |                                                      |
| host_status                          |                                                      |
| id                                   | d8e156a7-fa6b-41a7-8d3e-8a9cd3026745                 |
| image                                | Ubuntu_Xenial (9b200832-0a85-4863-b63e-0c9ee0a0da98) |
| key_name                             | -                                                    |
| locked                               | False                                                |
| metadata                             | {}                                                   |
| name                                 | Ubuntu_Dock                                          |
| os-extended-volumes:volumes_attached | []                                                   |
| progress                             | 0                                                    |
| security_groups                      | default                                              |
| status                               | BUILD                                                |
| tags                                 | []                                                   |
| tenant_id                            | e944c2a38232499398d3f27ce1209b99                     |
| updated                              | 2018-03-01T19:18:46Z                                 |
| user_id                              | a208593ca78f47dda14b62fe12e40e35                     |
+--------------------------------------+------------------------------------------------------+
```

**Build after nova boot**
```
[xxxx@director ~]$ nova list | grep Dock
| d8e156a7-fa6b-41a7-8d3e-8a9cd3026745 | Ubuntu_Dock          | BUILD   | spawning   | NOSTATE     | CLOUD1-OAM-NET=10.101.200.34; CLOUD1-PRI-PROVIDER-NET=172.17.129.26                                                                                                                        |
```

**Verify VM status **

```
[xxxx@director ~]$ nova list | grep Dock
| d8e156a7-fa6b-41a7-8d3e-8a9cd3026745 | Ubuntu_Dock          | ACTIVE  | -          | Running     | CLOUD1-OAM-NET=10.101.200.34; CLOUD1-PRI-PROVIDER-NET=172.17.129.26      |
```
 
