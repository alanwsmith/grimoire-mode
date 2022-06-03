#!/usr/bin/env python3

# This is a python version of the script to make
# it easier to do sorting and filtering. This
# will get things working. If it needs to be
# faster, that can be dealt with at another
# point.

import json
import keyring
import re
import requests
import sys

## TODO: return "Ready... if there is no search term"

token = keyring.get_password('alan--meilisearch--scratchpad--search-key', 'alan')

# set empty search term that will be used to return
# ready if nothing has been requested yet
search_term = ""

# use the search term from the command line
# if one is passed in
if len(sys.argv) == 2:
    search_term = sys.argv[1]

# print(search_term)

url = 'http://127.0.0.1:7700/indexes/grimoire/search'

headers = {
    'Authorization': f'Bearer {token}',
    'Content-Type': 'application/json'
}

data = {
    'q': search_term 
}

results_with_nonce = []
results_without_nonce = []

# get the initial string if there is one
# so you can put them first
match = re.search(f"^(\w+-)\s", search_term)

response = requests.post(url, headers=headers, json=data)


if match:
    # pull on the matches that hit the nonce word first
    for item in response.json()['hits']:
        if re.search(f"^{match[1]}", item['filename']):
            results_with_nonce.append(item['filename'])
        else:
            results_without_nonce.append(item['filename'])
else:
    for item in response.json()['hits']:
        # add to 'without' becuse of the way
        # we use it to extend next
        results_without_nonce.append(item['filename'])

# combine the lists
results_with_nonce.extend(results_without_nonce)


# TODO: return this Ready state earlier
# and without making a call to speed up
# the first results
if search_term == "":
    print("Ready...")
else:
    print("\n".join(results_with_nonce))


# print(results_with_nonce)
# print(results_without_nonce)


    # print(matches[1])


# if response.status_code == 200:
#     print(json.dumps(response.json(), indent=2, sort_keys=True))
# else:
#     print()


