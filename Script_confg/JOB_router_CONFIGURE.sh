#!/bin/bash
./goto.sh JOB router <<EOF
conf
ip route 6.0.0.0/8 Null0
interface ext_8_DUS
 ip address 179.6.8.1/24
exit

interface host
 ip address 6.108.0.2/24
exit

interface lo
 ip address 6.158.0.1/24
exit

interface measurement_6
 ip address 6.0.199.1/24
exit

interface port_FRA
 ip address 6.0.11.2/24
exit

router bgp 6
 bgp router-id 6.158.0.1
 neighbor 6.151.0.1 remote-as 6
 neighbor 6.151.0.1 update-source lo
 neighbor 6.152.0.1 remote-as 6
 neighbor 6.152.0.1 update-source lo
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
 neighbor 179.6.8.2 remote-as 8
 neighbor 179.6.8.2 description CUSTOMER_AS8
 

network 6.0.0.0/8
neighbor 6.151.0.1 next-hop-self
neighbor 6.152.0.1 next-hop-self
neighbor 6.153.0.1 next-hop-self
neighbor 6.154.0.1 next-hop-self
neighbor 6.155.0.1 next-hop-self
neighbor 6.156.0.1 next-hop-self
neighbor 6.157.0.1 next-hop-self
neighbor 179.6.8.2 route-map IN_AS8_CUSTOMER in
neighbor 179.6.8.2 route-map OUT_AS8_CUSTOMER out
 
exit

router ospf
 ospf router-id 6.158.0.1
 network 6.0.11.0/24 area 0
 network 6.0.199.0/24 area 0
 network 6.108.0.0/24 area 0
 network 6.158.0.0/24 area 0
exit

ip prefix-list ALLOWED_PREFIX_TO_CUSTOMER seq 5 permit 6.0.0.0/8
ip prefix-list ALLOWED_PREFIX_FROM_CUSTOMER seq 5 permit 8.0.0.0/8


bgp community-list standard ALLOWED_TAG_TO_CUSTOMER seq 5 permit 6:100 6:200 6:300

route-map OUT_AS8_CUSTOMER permit 10
match ip address prefix-list ALLOWED_PREFIX_TO_CUSTOMER

route-map OUT_AS8_CUSTOMER permit 20
match community ALLOWED_TAG_TO_CUSTOMER any

route-map IN_AS8_CUSTOMER permit 10
match ip address prefix-list ALLOWED_PREFIX_FROM_CUSTOMER
set community 6:300

route-map IN_AS8_CUSTOMER permit 20
match ip address prefix-list ALLOWED_PREFIX_FROM_CUSTOMER
set local-preference 300

exit
exit
exit
EOF



# scp -O -P 2006 ./JOB_router_CONFIGURE.sh root@mittelerde.vs.uni-kassel.de:/root/
# ssh -p 2006 root@mittelerde.vs.uni-kassel.de "chmod +x /root/JOB_router_CONFIGURE.sh && /root/JOB_router_CONFIGURE.sh"
# 2c7eac91273b7027