#!/bin/bash 

# Keeping dev on 7700 and will move prod to something else
export MEILI_MASTER_KEY=$(security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--root-key)
export MEILI_HTTP_ADDR=127.0.0.1:7700
export MEILI_ENV=development
export MEILI_DB_PATH=/Users/alan/data/meilisearch-scratchpad/data.ms
export MEILI_NO_ANALYTICS=true
export MEILI_LOG_LEVEL=DEBUG

meilisearch

