#!/usr/bin/env bash

OATHENS_SCHEME=https
OATHENS_HOST=connect.openathens.net
OATHENS_PORT=443
OATHENS_BASE_URL=$OATHENS_SCHEME://$OATHENS_HOST:$OATHENS_PORT

CLIENT_ID=idp.ebscohost.com.oidc-app-v1.b9536094-e7da-4d79-a8f6-74b2914b28a5
CLIENT_SECRET=QwnsJ3rVcovGhRKOgvmlvDvHm
REDIRECT_URI=https://www.example.com/auth0-login
#http://localhost:8001/auth0-login
SCOPE1=email
SCOPE2=openid
SCOPE3=profile
STATE=UUID_0012345

rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "${encoded}"    # You can either set a return variable (FASTER)
  REPLY="${encoded}"   #+or echo the result (EASIER)... or both... :p
}



printf "\nSTEP 1.-------------- Copy this link and execute in your browser ---------------------------------------\n"
AUTH_CODE_ENDPOINT="$OATHENS_BASE_URL/oidc/auth?\
response_type=code&\
scope=openid%20profile%20email&\
state=$STATE&\
client_id=$CLIENT_ID&\
redirect_uri=$REDIRECT_URI"

#echo $( rawurlencode "$AUTH_CODE_ENDPOINT" )

echo $AUTH_CODE_ENDPOINT

#CHROME_AUTH_CODE_ENDPT="$(/usr/bin/open -a /Applications/Google\ Chrome.app --args \"$AUTH_CODE_ENDPOINT\")"
#echo $CHROME_AUTH_CODE_ENDPT

printf "\nSTEP 2.-------------- Copy the access code from your url and paste here to continue---------------------\n"
read CODE

printf "\nSTEP 3.-------------- Fetching Bearer access token -----------------------------------------------------\n"
curl -v -X POST --basic -u "idp.ebscohost.com.oidc-app-v1.b9536094-e7da-4d79-a8f6-74b2914b28a5:QwnsJ3rVcovGhRKOgvmlvDvHm"  -H "Content-Type:application/x-www-form-urlencoded;charset=UTF-8" -k -d "grant_type=authorization_code&code=J0xlscq4QUIhSn-18V0yR2xl4P2SfqNEBno1kvG_US8&redirect_uri=https://www.example.com/auth0-login" https://connect.openathens.net/oidc/token

