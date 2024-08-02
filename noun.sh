#!/bin/bash

API_KEY="85e4ae07-9439-4e50-b352-3542ce427812"
BASE_URL="https://www.dictionaryapi.com/api/v3/references/collegiate/json/"

get_noun_definition() {
    local word=$1
    local url="${BASE_URL}${word}?key=${API_KEY}"
    local response=$(curl -s "$url")

    if [ -z "$response" ]; then
        echo "No definition found for '$word'"
        return
    fi

    # Extract the noun pronunciation and definition
    local definition=$(echo "$response" | jq -r '
        .[] |
        select(.fl == "noun" and .shortdef) |
        .hwi.hw as $hw |
        .hwi.prs[0].mw as $prs |
        .shortdef[0] as $shortdef |
        "`\($prs // "")` (noun): \($shortdef | split(".")[0])"
    ' | tail -n 1)

    if [ -z "$definition" ]; then
        echo "No definition found for '$word'"
    else
        echo "$definition"
    fi
}

if [ $# -lt 1 ]; then
    echo "Usage: $0 <word>"
    exit 1
fi

word=$1
get_noun_definition "$word"
