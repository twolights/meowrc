WIFI_INTERFACE=en0
WIFI_GATEWAY=`netstat -rn -f inet | grep default | grep $WIFI_INTERFACE | cut -w -f 2`

route delete default
route delete default -ifscope $WIFI_INTERFACE
route add default $WIFI_GATEWAY

VPN_GATEWAY=`ifconfig | grep inet | fgrep -- '-->' | cut -w -f 3`

route add 10.141.51.0/24 $VPN_GATEWAY

hostname Sapphire

# IEEE Explore
# route add 13.35.7.25 120.126.206.176
# route add 13.35.7.42 120.126.206.176
# route add 13.35.7.49 120.126.206.176
# route add 13.35.7.12 120.126.206.176
