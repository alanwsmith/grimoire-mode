# grimoire-mode 

A Grimoire For Emacs Org-mode

## Usage

- Note that there's a bunch of hard coded stuff for my machine
- run meilisearch-utils/start-meilisearch.bash
- run meilisearch-utils/watcher.bash
- Use F5 in Emacs to open the grimoire


## TODO

- [] - Add ability to scroll preview file via hotkeys 
- [] - Add ability to scroll list of candiates via j/k with a modifier
- [] - Fix issue where if buffer has been edited and gets reference in the preview it asks if you want to close it. 
- [] - Open file directory for preview instead of via return from meilisearch
- [] - Pop out to a second window
- [] - Make new files 
- [] - Put in check to make sure Grimoire directory exists
- [] - Examine switching to helm-follow instead of custom function to do preview
- [] - Setup the watcher upload script skip directories and files that shouldn't be published (e.g. tmp files)
- [] - Only update files that changed in the search index
- [] - Remove files that have been delted or renamed from the search index
- [] - Setup after save hook so that it only runs in the grimiore (or maybe just org mode)
- [] - Check if watcher is running and start it if it's not
- [] - Check if meilisearch is running and start it if it's not. 
- [] - Look at switching to helm-follow-mode (which looks to fire "presistant action" on each cursor move)
