#!/bin/bash
./goto.sh DUS router <<EOF
conf

interface ext_3_JOB
ip address 179.4.6.1/24

interface DUS-L2.10
ip address 6.200.1.2/24
ip ospf cost 1
exit

interface DUS-L2.20
ip address 6.200.0.2/24
ip ospf cost 1
exit

interface host
ip address 6.102.0.2/24
exit

interface lo
ip address 6.152.0.1/24
exit

interface port_ASB
ip address 6.0.8.1/24
exit

interface port_KAS
 ip address 6.0.1.2/24
 ip ospf cost 1
exit

interface port_STO
 ip address 6.0.7.1/24
exit

interface port_ZRH
 ip address 6.0.6.1/24
 ip ospf cost 1
exit

router bgp 6
 bgp router-id 6.152.0.1
 neighbor 6.151.0.1 remote-as 6
 neighbor 6.151.0.1 update-source lo
 neighbor 6.153.0.1 remote-as 6
 neighbor 6.153.0.1 update-source lo
 neighbor 6.154.0.1 remote-as 6
 neighbor 6.154.0.1 update-source lo
 neighbor 6.155.0.1 remote-as 6
 neighbor 6.155.0.1 update-source lo
 neighbor 6.156.0.1 remote-as 6
 neighbor 6.156.0.1 update-source lo
 neighbor 6.157.0.1 remote-as 6
 neighbor 6.157.0.1 update-source lo
 neighbor 6.158.0.1 remote-as 6
 neighbor 6.158.0.1 update-source lo
 

 network 6.0.0.0/8
 neighbor 6.151.0.1 next-hop-self
 neighbor 6.153.0.1 next-hop-self
 neighbor 6.154.0.1 next-hop-self
 neighbor 6.155.0.1 next-hop-self
 neighbor 6.156.0.1 next-hop-self
 neighbor 6.157.0.1 next-hop-self
 neighbor 6.158.0.1 next-hop-self
 neighbor 179.4.6.2 route-map IN_AS4_PROVIDER in
 neighbor 179.3.6.2 route-map OUT_AS4_PROVIDER out

exit

router ospf
 ospf router-id 6.152.0.1
 network 6.0.1.0/24 area 0
 network 6.0.6.0/24 area 0
 network 6.0.7.0/24 area 0
 network 6.0.8.0/24 area 0
 network 6.102.0.0/24 area 0
 network 6.152.0.0/24 area 0
 network 6.200.0.0/24 area 0
 network 6.200.1.0/24 area 0
exit



ip prefix-list ALLOWED_PREFIX_TO_PROVIDER seq 5 permit 6.0.0.0/8

bgp community-list standard ALLOWED_TAG_TO_PROVIDER seq 5 permit 6:300


route-map IN_AS4_PROVIDER permit 10
set community 6:100
route-map IN_AS4_PROVIDER permit 20
set local-preference 100


route-map OUT_AS4_PROVIDER permit 10
match ip address prefix-list ALLOWED_TAG_TO_PROVIDER

route-map OUT_AS3_PROVIDER permit 20
match community ALLOWED_PREFIX_TO_PROVIDER
exit


exit
exit

EOF
# scp -O -P 2006 ./DUS_router_CONFIGURE.sh root@mittelerde.vs.uni-kassel.de:/root/
# ssh -p 2006 root@mittelerde.vs.uni-kassel.de "chmod +x /root/DUS_router_CONFIGURE.sh && /root/DUS_router_CONFIGURE.sh"
# 2c7eac91273b7027
