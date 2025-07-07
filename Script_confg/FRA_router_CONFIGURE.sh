#!/bin/bash
./goto.sh FRA router <<EOF
conf
interface host
ip address 6.104.0.2/24
exit
interface ixp_82
ip address 108.82.0.8/24
exit
interface lo
ip address 6.154.0.1/24
exit
interface port_JOB
ip address 6.0.11.1/24
exit
interface port_KAS
ip address 6.0.3.2/24
ip ospf cost 1
exit
interface port_VIE
ip address 6.0.12.1/24
ip ospf cost 10
exit
interface port_ZRH
ip address 6.0.9.2/24
ip ospf cost 1
exit

router bgp 6
bgp router-id 6.154.0.1
neighbor 6.151.0.1 remote-as 6
neighbor 6.151.0.1 update-source lo
neighbor 6.152.0.1 remote-as 6
neighbor 6.152.0.1 update-source lo
neighbor 6.153.0.1 remote-as 6
neighbor 6.153.0.1 update-source lo
neighbor 6.155.0.1 remote-as 6
neighbor 6.155.0.1 update-source lo
neighbor 6.156.0.1 remote-as 6
neighbor 6.156.0.1 update-source lo
neighbor 6.157.0.1 remote-as 6
neighbor 6.157.0.1 update-source lo
neighbor 6.158.0.1 remote-as 6
neighbor 6.158.0.1 update-source lo
neighbor 180.82.0.82 route-map IN_BLOCK_DIFF_REGION in
neighbor 180.82.0.82 route-map OUT_IXP out

network 6.0.0.0/8
exit

router ospf
ospf router-id 6.154.0.1
network 6.0.3.0/24 area 0
network 6.0.9.0/24 area 0
network 6.0.11.0/24 area 0
network 6.0.12.0/24 area 0
network 6.104.0.0/24 area 0
network 6.154.0.0/24 area 0
exit

ip prefix-list ALLOWED_PREFIX_TO_IXP seq 5 permit 8.0.0.0/8

ip prefix-list NON_REGION_PREFIXES seq 5 permit 21.0.0.0/8
ip prefix-list NON_REGION_PREFIXES seq 10 permit 22.0.0.0/8
ip prefix-list NON_REGION_PREFIXES seq 15 permit 23.0.0.0/8
ip prefix-list NON_REGION_PREFIXES seq 20 permit 24.0.0.0/8
ip prefix-list NON_REGION_PREFIXES seq 25 permit 25.0.0.0/8
ip prefix-list NON_REGION_PREFIXES seq 30 permit 27.0.0.0/8
ip prefix-list NON_REGION_PREFIXES seq 35 permit 28.0.0.0/8
ip prefix-list NON_REGION_PREFIXES seq 40 permit 29.0.0.0/8
ip prefix-list NON_REGION_PREFIXES seq 45 permit 30.0.0.0/8
ip prefix-list NON_REGION_PREFIXES seq 50 permit 31.0.0.0/8
ip prefix-list NON_REGION_PREFIXES seq 55 permit 32.0.0.0/8

route-map IN_BLOCK_DIFF_REGION permit 10
match ip address prefix-list NON_REGION_PREFIXES
exit

route-map IN_BLOCK_DIFF_REGION deny 20
exit

route-map OUT_IXP permit 10
match ip address prefix-list ALLOWED_PREFIX_TO_IXP
set community 82:21 82:22 82:23 82:24 82:25 82:26 82:27 82:28 82:29 82:30 82:31 82:32
exit

exit
exit
EOF


# scp -O -P 2006 ./FRA_router_CONFIGURE.sh root@mittelerde.vs.uni-kassel.de:/root/
# ssh -p 2006 root@mittelerde.vs.uni-kassel.de "chmod +x /root/FRA_router_CONFIGURE.sh && /root/FRA_router_CONFIGURE.sh"
# 2c7eac91273b7027