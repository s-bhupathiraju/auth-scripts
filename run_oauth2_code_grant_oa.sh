#!/usr/bin/env bash

OATHENS_SCHEME=https
OATHENS_HOST=connect.openathens.net
OATHENS_PORT=443
OATHENS_BASE_URL=$OATHENS_SCHEME://$OATHENS_HOST:$OATHENS_PORT

CLIENT_ID=idp.ebscohost.com.oidc-app-v1.b9536094-e7da-4d79-a8f6-74b2914b28a5
CLIENT_SECRET=QwnsJ3rVcovGhRKOgvmlvDvHm
REDIRECT_URI=https://www.example.com/callback

STATE=UUID_0012345

printf "\nSTEP 1.-------------- Copy this link and execute in your browser ---------------------------------------\n"
AUTH_CODE_ENDPOINT="$OATHENS_BASE_URL/oidc/auth?response_type=code&scope=openid%20profile%20email&state=$STATE&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI"
echo $AUTH_CODE_ENDPOINT

printf "\nSTEP 2.-------------- Copy the code query parameter from your url and paste here to continue---------------------\n"
read CODE

TOKEN=$(curl -vk -X POST --basic -u "idp.ebscohost.com.oidc-app-v1.b9536094-e7da-4d79-a8f6-74b2914b28a5:QwnsJ3rVcovGhRKOgvmlvDvHm" -H "Content-Type: application/x-www-form-urlencoded;charset=UTF8" -d "grant_type=authorization_code&code=$CODE&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI" https://connect.openathens.net/oidc/token)

echo $TOKEN


