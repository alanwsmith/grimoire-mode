#!/bin/bash

fswatch -0 "/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Grimoire" | while read -d "" event
  do 
    echo "$event"
    /Users/alan/workshop/grimoire-mode/meilisearch-utils/update-index.py "$event"
  done
