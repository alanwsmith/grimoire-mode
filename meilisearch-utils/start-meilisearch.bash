#!/bin/bash 

export MEILI_MASTER_KEY=$(security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--root-key)
export MEILI_HTTP_ADDR=127.0.0.1:7575
export MEILI_ENV=development
export MEILI_DB_PATH=/Users/alan/data/meilisearch-scratchpad/data.ms
export MEILI_NO_ANALYTICS=true

meilisearch

