#!/usr/bin/env python3

import hashlib
import keyring
import meilisearch
import os
import re
import sys


## Config 

domain = "http://localhost:7700"

index_name = 'grimoire'

admin_key = keyring.get_password(
    'alan--meilisearch--scratchpad--admin-key',
    'alan'
)


## Functions

def string_to_md5(string):
    return hashlib.md5(bytes(string, encoding="utf-8")).hexdigest()


def do_update():
    if (len(sys.argv) > 1):

        update = True

        file_path = sys.argv[1]
        file_basename = os.path.basename(file_path).split('.')[0]
        file_extension = os.path.splitext(file_path)[1].lower()

        if file_extension != ".org":
            update = False

        if len(file_basename) == 0:
            update = False

        if len(file_basename) == 0 or re.search(r"^\W", file_basename[0]):
            update = False

        if update == True:

            print(f"Updating: {file_path}")

            with open(file_path, 'r', encoding='utf-8', errors='ignore') as _in:

                client = meilisearch.Client(
                    domain,
                    admin_key
                )

                filename = file_path.split('/')[-1]
                id_string = string_to_md5(file_path)
                content = _in.read()

                payload = {
                    "id": id_string,
                    "filename": filename,
                    "content": content
                }

                response_upload = client.index(index_name).add_documents(payload)

        else:
            print(f"Skipping: {file_path}")

if __name__ == "__main__":
    do_update()

