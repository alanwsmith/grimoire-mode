#!/bin/bash


  # echo $(ksuid)
  curl -s \
      -H "Authorization: Bearer $(security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--root-key)" \
      -X DELETE 'http://localhost:7575/indexes/grimoire/documents' 
  # cd "/Users/alan/workshop/grimoire-mode/samples/set-3"
  cd "/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Grimoire"
  for FILE in * 
  do
      ID_HASH=$(echo -n $FILE | md5)
   # echo "$FILE"
   # echo $ID_HASH
   jq -Rsn --rawfile content "$FILE" --arg filename "$FILE" --arg id $ID_HASH -f "/Users/alan/workshop/grimoire-mode/meilisearch-utils/template.jq" > "/Users/alan/workshop/grimoire-mode/meilisearch-utils/tmp.json"
      curl -s \
          -X POST 'http://localhost:7575/indexes/grimoire/documents' \
       -H "Authorization: Bearer $(security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--root-key)" \
       -H 'Content-Type: application/json' \
       --data-binary "@/Users/alan/workshop/grimoire-mode/meilisearch-utils/tmp.json" > /dev/null
   done



