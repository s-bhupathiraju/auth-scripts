#!/usr/bin/env bash

WSO2_SCHEME=https
WSO2_HOST=localhost
WSO2_PORT=9443
WSO2_BASE_URL=$WSO2_SCHEME://$WSO2_HOST:$WSO2_PORT
# localhost hellosp
CLIENT_ID=pQslJ8jaInzkzcsAErJJg25rJCka
CLIENT_SECRET=K2jq8pAjCUzsUy_ptwBgEth7R0sa
REDIRECT_URI=http://example.com

BASE64_BASIC_AUTH=c3VudmFyOnN1bnZhcg==

echo "\n-------------- Copy this link and execute in your browser--------------------\n"
echo "$WSO2_BASE_URL/oauth2/authorize?response_type=code&scope=openid&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI\n"
echo "Copy the access code from your url and paste here to continue\n"
read CODE

TOKEN=$(curl -vk -X POST -H "Authorization: Basic $BASE64_BASIC_AUTH" -H "Content-Type: application/x-www-form-urlencoded;charset=UTF8" -d "grant_type=authorization_code&code=$CODE&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI" https://localhost:9443/oauth2/token)

echo $TOKEN

# ruby parse-oauth-token.rb "$TOKEN"
#
# echo "Enter the access token from the response..."
# read ACCESS_TOKEN
# SAML_ISSUER=plansource.com
# SAML_RESPONSE=$(curl -vk -X POST -H "Content-Type: application/x-www-form-urlencoded;charset=UTF-8" -d "token=$ACCESS_TOKEN&issuer=$SAML_ISSUER" https://ec2-23-23-196-189.compute-1.amazonaws.com:9443/oauth2saml/token)
#
# echo "\n----------SAML RESPONSE----------------\n"
# echo $SAML_RESPONSE
# echo "\n----------SAML RESPONSE----------------\n"

#echo "\nPress enter to call PlanSource Subscriber API with SAML Response\n"
#read RESPONSE

#curl -v -H "SAMLResponse: $SAML_RESPONSE" -H "RelayState: https://benefits.plansource.com/sso/employee/saml2/post/38f86faba712e097" https://trion-benefits.plansourcedev.com/v1/self_service/subscriber
