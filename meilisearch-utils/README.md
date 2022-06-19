This is for the first set up utils

New scripts are being created in meilisearch-updaters
that will include facet search. Once those are ready
these will be removed. 

Details:

watcher.bash watches the directory
when it sees changed files, it sends them to update-index.py

start-meilisearch - is what fires the process up

rebuild_index.py - deletes the index and rebuilds it with a
fresh set of data from the files.

