#!/bin/bash

fswatch -0 "/Users/alan/Grimoire" | while read -d "" event
  do
      /Users/alan/workshop/grimoire-mode/meilisearch-updaters/src/update-document.js "$event"
  done
