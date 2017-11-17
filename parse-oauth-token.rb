#! /usr/bin/env ruby

require 'json'
require 'base64'

def decode_tokens(token)
   result = token.split(".").collect { |item| Base64.decode64(item) }
   #puts "\n----------------------\n#{result}"
end

def parse_id_token_body(id_tokens)
  #jwt token has header, body, signature...we're only interested in the body
  id_token_body = JSON.parse(id_tokens)
end

oauth_token = JSON.parse(ARGV[0])

puts "\nOriginal Payload" + oauth_token.to_s

#id_token_header = parse_id_token_body(decode_tokens(oauth_token["access_token"])[0])
id_token_body = parse_id_token_body(decode_tokens(oauth_token["access_token"])[1])
#id_token_signature = parse_id_token_body(decode_tokens(oauth_token["access_token"])[2])

oauth_token["access_token"] = id_token_body

puts  "\n------------------------------"
#puts JSON.pretty_generate(id_token_header)
#puts JSON.pretty_generate(id_token_body)
#puts JSON.pretty_generate(id_token_header)
puts JSON.pretty_generate(oauth_token)
