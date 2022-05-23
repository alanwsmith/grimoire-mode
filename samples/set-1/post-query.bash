curl -s \
  	-X POST 'http://127.0.0.1:7575/indexes/set-1/search' \
    -H "Authorization: Bearer $(security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--search-key)" \
  	-H 'Content-Type: application/json' \
    --data-binary '{ "q": "fox" }' \
    | jq -r '.hits[] | .path'





