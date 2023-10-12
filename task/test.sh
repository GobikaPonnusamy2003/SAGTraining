#!/bin/bash
url="https://itrac.eur.ad.sag/rest/api/latest/issue/WF-30753"
username="****"
password="***************"
word_to_count="inwardIssue"
keys_to_extract=".fields.issuelinks[].inwardIssue.key"
response=$(curl -u "$username:$password" "$url")
if [ $? -eq 0 ]; then
  word_count=$(echo "$response" | jq --raw-output '. | tostring' | grep -o "\b$word_to_count\b" | wc -l)
  extracted_keys=$(echo "$response" | jq --raw-output "$keys_to_extract")
  echo "Word Count for '$word_to_count': $word_count"
  echo "Extracted Keys: $extracted_keys"
  issuetype_ids=$(echo "$response" | jq --raw-output '.fields.issuelinks[].inwardIssue.fields.issuetype.id')
  for issuetype_id in $issuetype_ids; do
    if [ "$issuetype_id" == "15" ]; then
      issuetype_self_url=$(echo "$response" | jq --raw-output '.fields.issuelinks[] | select(.inwardIssue.fields.issuetype.id == "15") | .inwardIssue.fields.issuetype.self')
      echo "Self URL for Issuetype ID 15: $issuetype_self_url"
    fi
  done
else
  echo "HTTP request failed with an error"
fi

