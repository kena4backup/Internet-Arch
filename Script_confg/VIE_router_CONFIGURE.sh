#!/bin/bash
./goto.sh VIE router <<EOF
conf
ip route 6.0.0.0/8 Null0
interface ext_5_VIE
ip address 179.5.6.1/24
exit
interface host
ip address 6.107.0.2/24
exit
interface lo
ip address 6.157.0.1/24
exit
interface port_FRA
ip address 6.0.12.2/24
ip ospf cost 10
exit
interface port_KAS
ip address 6.0.5.2/24
exit

router bgp 6
bgp router-id 6.157.0.1
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
neighbor 6.158.0.1 remote-as 6
neighbor 6.158.0.1 update-source lo
neighbor 179.5.6.2 remote-as 5
neighbor 179.5.6.2 description PEER _AS5

network 6.0.0.0/8
neighbor 6.151.0.1 next-hop-self
neighbor 6.152.0.1 next-hop-self
neighbor 6.153.0.1 next-hop-self
neighbor 6.154.0.1 next-hop-self
neighbor 6.155.0.1 next-hop-self
neighbor 6.156.0.1 next-hop-self
neighbor 6.158.0.1 next-hop-self
neighbor 179.5.6.2 route-map IN_AS5_PEER in
neighbor 179.5.6.2 route-map OUT_AS5_PEER out
exit

router ospf
ospf router-id 6.157.0.1
network 6.0.5.0/24 area 0
network 6.0.12.0/24 area 0
network 6.107.0.0/24 area 0
network 6.157.0.1/32 area 0
exit

ip prefix-list ALLOWED_PREFIX_FROM_PEER seq 5 permit 5.0.0.0/8

ip prefix-list ALLOWED_PREFIX_TO_PEER seq 5 permit 6.0.0.0/8
bgp community-list standard ALLOWED_TAG_TO_PEER seq 5 permit 6:300

route-map OUT_AS5_PEER permit 10
match ip address prefix-list ALLOWED_PREFIX_TO_PEER
route-map OUT_AS5_PEER permit 20
match community ALLOWED_TAG_TO_PEER

route-map IN_AS5_PEER permit 10
match ip address prefix-list ALLOWED_PREFIX_FROM_PEER
set community 6:200
exit

exit
exit
EOF

# scp -O -P 2006 ./VIE_router_CONFIGURE.sh root@mittelerde.vs.uni-kassel.de:/root/
# ssh -p 2006 root@mittelerde.vs.uni-kassel.de "chmod +x /root/VIE_router_CONFIGURE.sh && /root/VIE_router_CONFIGURE.sh"
# 2c7eac91273b7027