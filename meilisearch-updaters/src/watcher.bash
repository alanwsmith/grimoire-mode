#!/bin/bash

fswatch -0 "/Users/alan/Grimoire" | while read -d "" event
  do 
    # echo "$event"
    /Users/alan/workshop/grimoire-mode/meilisearch-utils/update-document.py "$event"
  done
