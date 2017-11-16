#!/bin/bash
printf "\n-------------- Enter your GitHub credentials -------------------------------\n"

# How does this work?
# -------------------
# With this model, users must authenticate themselves with the corresponding username and password for each realm.
# A given user can belong to multiple realms simultaneously. The value of the realm is shown to the user at
# the time of authentication. It allows the resources on the server to be partitioned into a set of protection domains,
# each with its own authentication scheme and/or authorization database. The realm value is a string,
# which is assigned by the authentication server. Once the request hits the server with Basic Authentication credentials,
# the server will accept the request only if it can validate the username and the password for the protected resource.

read -p 'Username: ' GitHubUserName
read -sp 'Password: ' GitHubPassword

printf "\n-------------- Executing Basic Authentication on GitHub --------------------\n"

# Using Basic Authentication and passing in the user and password for a default realm
# -i include http headers in the output
# –v is used to run cURL in verbose mode.
# –H is used to set HTTP headers in the outgoing request
# –d is used to post data to the endpoint.
# -o output to a stream or a file
# -X HTTP verb used
curl -v -s -i -o /dev/null -w "%{http_code}" -u $GitHubUserName:$GitHubPassword -X GET https://api.github.com/user/repos

printf "\n"
