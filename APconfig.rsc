# mar/05/2021 22:20:02 by RouterOS 6.47.9
# model = RouterBOARD 941-2nD
#
/interface bridge
add name=Bridge-generalS
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa2-psk eap-methods="" mode=dynamic-keys name=\
    profile1 supplicant-identity="" wpa2-pre-shared-key=****
/interface wireless
set [ find default-name=wlan1 ] adaptive-noise-immunity=ap-and-client-mode \
    band=2ghz-g/n country=russia disabled=no hw-protection-mode=rts-cts \
    installation=indoor mode=ap-bridge name=wlan-2GHz security-profile=\
    profile1 ssid=Test-2GHz wireless-protocol=802.11 wmm-support=enabled \
    wps-mode=disabled
/interface bridge port
add bridge=Bridge-generalS interface=ether1
add bridge=Bridge-generalS interface=ether2
add bridge=Bridge-generalS interface=ether3
add bridge=Bridge-generalS interface=ether4
add bridge=Bridge-generalS interface=wlan-2GHz
/ip dhcp-client
add disabled=no interface=Bridge-generalS
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh disabled=yes
set api disabled=yes
set api-ssl disabled=yes
/system clock
set time-zone-name=Asia/Tomsk
/system identity
set name=WhiteSlave
