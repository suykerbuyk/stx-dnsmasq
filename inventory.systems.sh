#!/bin/sh

# the id.systems.sh script
#  #!/bin/sh
#  
#  . /etc/*release
#  SNAME=$(dmidecode -s system-product-name)
#  SUUID=$(dmidecode -s system-uuid)
#  BMC_MAC=$(ipmitool lan print | grep "MAC Address"  | sed 's/MAC Address             : //g')
#  BMC_IP=$( ipmitool lan print | grep "IP Address   "| sed 's/IP Address              : //g')
#  
#  echo -n "$HOSTNAME, $SNAME, $ID, $VERSION_ID, $SUUID, $BMC_MAC, $BMC_IP"
#  for NIC in $(ip a | grep 'mq state UP group' | grep -v dock | awk '{print $2'} | tr -d ':')
#  do
#  	IP="$(ip address show $NIC | grep 'inet ' | awk '{print $2}' | sed 's/\/.*//g')"
#  	MAC="$(ip address show $NIC | grep ' link/ether ' | awk '{print $2}')"
#  	if [ "${IP}x" == "x" ] ; then
#  		IP="000.000.000.000"
#  	fi
#  	echo -n ", $NIC, $IP, $MAC"
#  done
#  echo
#  

for TGT in $(cat /opt/stx/stx-dnsmasq/dnsmasq.lease | awk  '{print $4}' | egrep '4u100|lr|hr' | egrep -v 'sw|sp|data|ipmi|mgmt|vm' | sort)
do 
	ssh root@${TGT} 'curl -s mgmt/repo/helpers/id.system.sh | sh'
done

