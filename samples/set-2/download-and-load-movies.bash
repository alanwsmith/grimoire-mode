curl -s https://docs.meilisearch.com/movies.json --output movies.json

curl -s \
  -X POST 'http://127.0.0.1:7575/indexes/movies/documents' \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $(security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--admin-key)" \
  --data-binary @movies.json

