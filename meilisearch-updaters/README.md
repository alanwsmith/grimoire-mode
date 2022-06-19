Meilisearch Updaters

NOTE: The rebuild-index.js script is working
and is set to only do a single directroy
by hard coding ListDir recursive to false
in the library file.

- these are the second version of the scripts
  they include tests and facets for each
  file
- Facets are nonce works like `py-` and `cfg-`
- Facets are pulled from the file name
  or from `#+FACET:` headers in the documents
- Ids for meilisearch are pulled from the
  `ID:` header. If there's not one it just
  squashes the file name. This might lead
  to some duplicates, but that's fine since
  files will trened toward having

NOTE That the title field is filled out, but
nothing is done for it with files that don't
have a title header. It's not really being
used right now, so that shouldn't be an issue.
