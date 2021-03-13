# mar/13/2021 19:04:54 by RouterOS 6.47.9
# model = RBD52G-5HacD2HnD
/ppp profile
add change-tcp-mss=yes dns-server=8.8.8.8 local-address=172.16.30.1 name=\
    profile1 only-one=no remote-address=172.16.30.2 use-compression=no \
    use-encryption=yes use-mpls=no use-upnp=no
/interface pppoe-server server
add authentication=mschap1,mschap2 default-profile=profile1 disabled=no \
    interface=ether5 one-session-per-host=yes service-name=forWhite
/ip address
add address=172.18.0.200/16 disabled=yes interface=WAN-ether1 network=\
    172.18.0.0
/ppp secret
add name=White password=A123 profile=profile1
