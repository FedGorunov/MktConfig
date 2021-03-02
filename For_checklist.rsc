
/caps-man channel
add band=2ghz-b/g/n control-channel-width=20mhz extension-channel=disabled \
    frequency=2412 name=channel1
add band=2ghz-b/g/n control-channel-width=20mhz extension-channel=disabled \
    frequency=2437 name=channel6
add band=2ghz-b/g/n control-channel-width=20mhz extension-channel=disabled \
    frequency=2462 name=channel11
/interface bridge
add name=Bridge-generalM
/interface ethernet
set [ find default-name=ether1 ] name=WAN-ether1
/caps-man datapath
add bridge=Bridge-generalM name=datapath1
/caps-man security
add authentication-types=wpa2-psk encryption=aes-ccm name=Test-security \
    passphrase=Abcd1234
/caps-man configuration
add channel=channel6 country=russia3 datapath=datapath1 distance=indoors \
    hw-protection-mode=cts-to-self max-sta-count=20 mode=ap name=Test-cfg \
    rx-chains=0,1,2,3 security=Test-security ssid=Test-Cap tx-chains=0,1,2,3
/caps-man interface
add channel=channel1 channel.frequency=2437 configuration=Test-cfg datapath=\
    datapath1 disabled=no l2mtu=1600 mac-address=48:8F:5A:CD:2F:4F \
    master-interface=none name=BlackMaster radio-mac=48:8F:5A:CD:2F:4F \
    radio-name=488F5ACD2F4F security=Test-security
add channel=channel1 channel.frequency=2437 configuration=Test-cfg datapath=\
    datapath1 disabled=no l2mtu=1600 mac-address=CC:2D:E0:59:CE:61 \
    master-interface=none name=WhiteSlave1 radio-mac=CC:2D:E0:59:CE:61 \
    radio-name=CC2DE059CE61 security=Test-security
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=\
    profile1-test supplicant-identity="" wpa2-pre-shared-key=Abcd1234
/interface wireless
# managed by CAPsMAN
# channel: 2437/20/gn(17dBm), SSID: Test-Cap, CAPsMAN forwarding
set [ find default-name=wlan1 ] adaptive-noise-immunity=ap-and-client-mode \
    band=2ghz-b/g/n channel-width=20/40mhz-eC country=russia frequency=2432 \
    hw-protection-mode=cts-to-self installation=indoor mode=ap-bridge name=\
    wlan-2GHz security-profile=profile1-test ssid=Test-2HGz \
    wireless-protocol=802.11 wmm-support=enabled wps-mode=disabled
set [ find default-name=wlan2 ] adaptive-noise-immunity=ap-and-client-mode \
    band=5ghz-a/n/ac channel-width=20/40/80mhz-eeCe country=russia frequency=\
    auto hw-protection-mode=rts-cts installation=indoor mode=ap-bridge name=\
    wlan_5GHz security-profile=profile1-test ssid=Test-5GHz \
    wireless-protocol=802.11 wmm-support=enabled wps-mode=disabled
/ip hotspot profile
set [ find default=yes ] html-directory=flash/hotspot
/ip pool
add name=DHCP-pool ranges=192.168.10.10-192.168.10.200
/ip dhcp-server
add address-pool=DHCP-pool disabled=no interface=Bridge-generalM lease-time=\
    1d name=DHCP-server1
/caps-man manager
set enabled=yes
/caps-man provisioning
add action=create-dynamic-enabled ip-address-ranges=192.168.10.0/24 \
    master-configuration=Test-cfg name-format=prefix-identity name-prefix=\
    TestCap
add action=create-dynamic-enabled master-configuration=Test-cfg radio-mac=\
    CC:2D:E0:59:CE:61
/interface bridge port
add bridge=Bridge-generalM interface=wlan_5GHz
add bridge=Bridge-generalM interface=ether2
add bridge=Bridge-generalM interface=ether3
add bridge=Bridge-generalM interface=ether4
add bridge=Bridge-generalM interface=ether5
/interface wireless cap
# 
set bridge=Bridge-generalM caps-man-addresses=192.168.10.1 enabled=yes \
    interfaces=wlan-2GHz
/ip address
add address=192.168.10.1/24 interface=Bridge-generalM network=192.168.10.0
add address=172.18.0.200/16 disabled=yes interface=WAN-ether1 network=\
    172.18.0.0
/ip dhcp-client
add disabled=no interface=WAN-ether1
/ip dhcp-server network
add address=192.168.10.0/24 dns-server=192.168.10.1 gateway=192.168.10.1 \
    netmask=24
/ip dns
set allow-remote-requests=yes servers=8.8.8.8
/ip firewall nat
add action=masquerade chain=srcnat out-interface=WAN-ether1
/system clock
set time-zone-name=Asia/Tomsk
/system identity
set name=BlackMaster
