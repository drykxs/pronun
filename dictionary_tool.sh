#!/bin/bash

API_KEY="x"
BASE_URL="https://www.dictionaryapi.com/api/v3/references/collegiate/json/"

get_noun_definition() {
    local word=$1
    response=$(curl -s "${BASE_URL}${word}?key=${API_KEY}")

    prs=$(echo "$response" | jq -r '.[0].hwi.prs[0].mw // empty')
    definition=$(echo "$response" | jq -r '.[0].shortdef[0]' | grep -Eo '^[^.]+')
    echo "\`$prs\` (noun): $definition."
}

if [ $# -lt 1 ]; then
    echo "Usage: $0 <word>"
    exit 1
fi

word=$1
definition=$(get_noun_definition "$word")
echo "$definition"
