# grimoire-mode 

## Overview

A Personal Grimoire for Emacs Org-mode

This is an emacs major mode I put together to replace
nvAlt which is the notes app I used for more than a decade.

I call it my Grimoire, which is a book of magic. It's where
I store my notes and code snippets. nvAlt was great for this, 
but Emacs Org mode is even better. It lets you execute
code snippets directly in the notes and output the return 
values into the notes themselves. It's amazing.

I built this for myself. There's lots of stuff that's hard
coded directly to my machine. You're welcome to use it for 
inspiration or to take a swing at getting it to work for 
yourself, but don't be surprised if that requires a lot
of fiddling. 


## TODO

- [x] - Fix issue where if buffer has been edited and gets reference in the preview it asks if you want to close it. 
- [x] - Open file directly for preview instead of via return from meilisearch
- [x] - Add ability to pop out to a second window 
- [x] - Make new files 
- [x] - Only update files that changed in the search index
- [x] - Setup the watcher upload script skip directories and files that shouldn't be published (e.g. tmp files)
- [ ] - Setup flag to see files behind streamer mode vail
- [ ] - Add ability to scroll preview file via hotkeys 
- [ ] - Add ability to scroll list of candiates via j/k with a modifier
- [ ] - Put in check to make sure Grimoire directory exists
- [ ] - Remove files that have been delted or renamed from the search index
- [ ] - Check if watcher is running and start it if it's not
- [ ] - Check if meilisearch is running and start it if it's not

