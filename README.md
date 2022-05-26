# grimoire-mode 

A Grimoire For Emacs Org-mode

## Usage

- Note that there's a bunch of hard coded stuff for my machine
- run meilisearch-utils/start-meilisearch.bash
- run meilisearch-utils/watcher.bash
- Use F5 in Emacs to open the grimoire


## TODO

- [] - Setup the watcher upload script skip directories and files that shouldn't be published (e.g. tmp files)
- [] - Only update files that changed in the search index
- [] - Remove files that have been delted or renamed from the search index
- [] - Setup after save hook so that it only runs in the grimiore (or maybe just org mode)
- [] - Check if watcher is running and start it if it's not
- [] - Check if meilisearch is running and start it if it's not. 

