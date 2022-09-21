#!/bin/sh

IP=192.16.1.1
DATE=$(date +%F)
LOGFILE="provisioning_failures$DATE.txt"

fatal() { echo "ERROR: $1" >> $LOGFILE; exit; }

deploy_values() {
	ssh root@$IP uci set wireless.wifinet0.ssid=$1 || fatal "uci ssid failed"
        ssh root@$IP uci commit wireless || fatal "uci ssid commit failed"
        ssh root@$IP /etc/init.d/wireless restart || fatal "init.d wireless restart failed"        
        }

deploy_files() {
	scp files/* root@$IP:/etc/config || fatal "scp failed"


}
deploy_files 
deploy_values "$1"
