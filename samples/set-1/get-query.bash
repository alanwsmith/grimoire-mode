curl -s \
  	-X GET "http://127.0.0.1:7575/indexes/set-1/search?q=fox" \
    -H "Authorization: Bearer $(security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--search-key)" \
	| jq -r ".hits[] | .path"
