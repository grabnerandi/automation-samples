#!/bin/bash

echo ""
echo "This script will send a couple of 'load testing metrics' to a Dynatrace monitored service"
echo "It can be used for load testing providers to see whats possible with the Metrics API"
echo ""
echo "Pre-Requisits: please set the following env-variables"
echo "DT_TENANT: the Url to your Dynatrace Tenant, e.g: abc12345.dynatrace.live.com"
echo "DT_API_TOKEN: a Dynatrace API token with the 'Ingest metrics using APIv2' privildge"
echo "DT_SERVICE_ID: a valid Dynatrace Service ID, e.g: SERVICE-ABCD123131"

if [[ -z "$DT_TENANT" || -z "$DT_API_TOKEN" || -z "$DT_SERVICE_ID" ]]; then
  echo "DT_TENANT & DT_API_TOKEN and DT_SERVICE_ID MUST BE SET!!"
  exit 1
fi

read -rsp $'Press ctrl-c to abort. Press any key to continue...\n' -n1 key
echo ""

echo "test.vucount,testname=\"my test\",dt.entity.service=$DT_SERVICE_ID 10"> payload.txt
echo "test.errorrate,testname=\"my test\",dt.entity.service=$DT_SERVICE_ID 0">> payload.txt
echo "test.transaction.responsetime,testname=\"my test\",transaction=\"homepage\",dt.entity.service=$DT_SERVICE_ID gauge,min=100,max=500,sum=2200,count=10">> payload.txt
echo "test.transaction.errorrate,testname=\"my test\",transaction=\"homepage\",dt.entity.service=$DT_SERVICE_ID gauge,min=0,max=2,sum=5,count=10">> payload.txt
echo "test.transaction.responsetime,testname=\"my test\",transaction=\"checkout\",dt.entity.service=$DT_SERVICE_ID gauge,min=200,max=1100,sum=4200,count=10">> payload.txt
echo "test.transaction.errorrate,testname=\"my test\",transaction=\"checkout\",dt.entity.service=$DT_SERVICE_ID gauge,min=0,max=4,sum=8.0,count=10">> payload.txt

curl -X POST \
        "https://$DT_TENANT/api/v2/metrics/ingest" \
        -H "Authorization: Api-Token $DT_API_TOKEN" \
        -H "accept: */*" \
        -H "Content-Type: text/plain; charset=utf-8" \
        --data-binary "@payload.txt" \
        -o curloutput.txt