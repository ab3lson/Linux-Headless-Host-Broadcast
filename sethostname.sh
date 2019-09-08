currentHost=$(cat /etc/hostname)
hostcheck=$(ifconfig eth0 |awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print "chapi-"$2}')
hostcheck=${hostcheck//[.]/-}

if [ -z "$hostcheck" ]
then
	echo "eth0 is not plugged in! Checking wlan0..."
	hostcheck=$(ifconfig wlan0 |awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print "chapi-"$2}')
	hostcheck=${hostcheck//[.]/-}
	echo "IP Address: $hostcheck"
	echo "Current Host: $currentHost"
	if [ $hostcheck != $currentHost ]
	then
		newhostname=$(ifconfig wlan0 |awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print "chapi-"$2}')
       		echo $newhostname > newhostname.txt
       		newhostname=${newhostname//[.]/-}
       		echo $newhostname > newhostname.txt
       		sudo cp /etc/hosts hostsEDIT
       		echo "removing old hostname from /etc/hosts"
       		sed -i '$ d' hostsEDIT
       		cat hostsEDIT
       		echo "adding new hostname to /etc/hosts"
       		echo "127.0.1.1       $newhostname" >> hostsEDIT
       		cat hostsEDIT
       		sudo cp hostsEDIT /etc/hosts
       		echo "Setting new hostname to $newhostname in /etc/hostname"
       		sudo mv newhostname.txt /etc/hostname
		echo "Hostname changed... going to reboot"
		sleep 3s
		sudo reboot
	else
        	echo "Hostname is already your current IP Address"
	fi
else
	echo "IP Address: $hostcheck"
        echo "Current Host: $currentHost"
        if [ $hostcheck != $currentHost ]
	then
		newhostname=$(ifconfig eth0 |awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print "chapi-"$2}')
        	echo $newhostname > newhostname.txt
        	newhostname=${newhostname//[.]/-}
        	echo $newhostname > newhostname.txt
        	sudo cp /etc/hosts hostsEDIT
        	echo "removing old hostname from /etc/hosts"
        	sed -i '$ d' hostsEDIT
        	cat hostsEDIT
        	echo "adding new hostname to /etc/hosts"
        	echo "127.0.1.1       $newhostname" >> hostsEDIT
        	cat hostsEDIT
        	sudo cp hostsEDIT /etc/hosts
        	echo "Setting new hostname to $newhostname in /etc/hostname"
        	sudo mv newhostname.txt /etc/hostname
		echo "Hostname changed... going to reboot"
                sleep 3s
                sudo reboot
	else
		echo "Hostname is already your current IP Address"
	fi 
fi

