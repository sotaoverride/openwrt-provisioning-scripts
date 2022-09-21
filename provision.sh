#!/bin/sh

DATE=$(date +%F)
LOGFILE="provisioning_failures$DATE.txt"

#Bounce backend API url

BOUNCE_API_URL="http:/"

fatal() { echo "ERROR: $1 \n"i >> $LOGFILE; exit; }

fetch_values() {
	test -z $1 || fatal "no serial number"
	curl -f $BOUNCE_API_URL$1 > fetched.json || fatal "curl failed"
	test -s fetched.json || fatal "request is zero bytes"
	SSID=$(jq '.ssid' < fetched.json) || fatal "ssid jq failed"
	}

fetch_values "$1"
./deploy.sh "$SSID"
