#!/usr/bin/env bash

AUTH0_SCHEME=https
AUTH0_HOST=sbhupathiraju-ebsco.auth0.com
AUTH0_PORT=443
AUTH0_BASE_URL=$AUTH0_SCHEME://$AUTH0_HOST:$AUTH0_PORT
# localhost hellosp
CLIENT_ID=q4xGl4gizkR5QNHQuTEIfu8jFPtAV540
CLIENT_SECRET=7ZZ_Xk3ycaFU2UmdQismfsCx2SPLmrM82nGNe_ki1D0yngvltcIrMUW9iyXjWS-H
REDIRECT_URI=http://example.com
SCOPE1=profile
SCOPE2=email
SCOPE3=offline_access
BASE64_BASIC_AUTH=NWEwZjE3ZjFkYTA1N2EwNzMwMTM4NGU2OmhlbGxv
STATE=UUID_0012345
API_IDENTIFIER=http://example.com/api/v2

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
AUTH_CODE_ENDPOINT="$AUTH0_BASE_URL/authorize?\
response_type=code&\
scope=openid%20profile%20offline_access&\
state=$STATE&\
audience=$API_IDENTIFIER&\
client_id=$CLIENT_ID&\
redirect_uri=$REDIRECT_URI"

#echo $( rawurlencode "$AUTH_CODE_ENDPOINT" )

echo $AUTH_CODE_ENDPOINT

CHROME_AUTH_CODE_ENDPT="$(/usr/bin/open -a /Applications/Google\ Chrome.app --args \"$AUTH_CODE_ENDPOINT\")"
echo $CHROME_AUTH_CODE_ENDPT

printf "\nSTEP 2.-------------- Copy the access code from your url and paste here to continue---------------------\n"
read CODE

printf "\nSTEP 3.-------------- Fetching Bearer access token -----------------------------------------------------\n"

TOKEN="$(curl --request POST \
--url "$AUTH0_BASE_URL/oauth/token" \
--header "content-type: application/json" \
--data @<(cat <<EOF
{
  "grant_type": "authorization_code",
  "client_id": "$CLIENT_ID",
  "client_secret": "$CLIENT_SECRET",
  "code": "$CODE",
  "redirect_uri": "$REDIRECT_URI"
}
EOF
))"

echo $TOKEN

printf "\nSTEP 4.-------------- Using Bearer access token --------------------------------------------------------\n"
ruby parse-oauth-token.rb "$TOKEN"

echo "Enter the access token from the response..."
read ACCESS_TOKEN
