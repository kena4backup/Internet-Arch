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

network 6.0.0.0/8
neighbor 6.151.0.1 next-hop-self
neighbor 6.152.0.1 next-hop-self
neighbor 6.153.0.1 next-hop-self
neighbor 6.154.0.1 next-hop-self
neighbor 6.155.0.1 next-hop-self
neighbor 6.156.0.1 next-hop-self
neighbor 6.158.0.1 next-hop-self
neighbor 179.5.6.2 route-map ACCEPT_ALL in
neighbor 179.5.6.2 route-map ACCEPT_ALL out
exit

router ospf
ospf router-id 6.157.0.1
network 6.0.5.0/24 area 0
network 6.0.12.0/24 area 0
network 6.107.0.0/24 area 0
network 6.157.0.1/32 area 0
exit

exit
exit
EOF
