#!/bin/bash
url="https://itrac.eur.ad.sag/rest/api/latest/issue/WF-30753"
username="gopo"
password="Gomathi1982Gobicpg3"
word_to_count="inwardIssue"
keys_to_extract=".fields.issuelinks[].inwardIssue.key"
response=$(curl -u "$username:$password" "$url")
if [ $? -eq 0 ]; then
  word_count=$(echo "$response" | jq --raw-output '. | tostring' | grep -o "\b$word_to_count\b" | wc -l)
  extracted_keys=$(echo "$response" | jq --raw-output "$keys_to_extract")
  echo "Word Count for '$word_to_count': $word_count"
  echo "Extracted Keys: $extracted_keys"
else
  echo "HTTP request failed with an error"
fi
