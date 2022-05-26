#!/usr/bin/env python3

import hashlib
import keyring
import meilisearch
import sys

def string_to_md5(string):
    return hashlib.md5(bytes(string, encoding="utf-8")).hexdigest()


def do_update():
    if (len(sys.argv) > 1):
        file_path = sys.argv[1]

        with open(file_path, 'r', encoding='utf-8', errors='ignore') as _in:

            domain = "http://localhost:7700"

            admin_key = keyring.get_password(
                'alan--meilisearch--scratchpad--admin-key',
                'alan'
            )

            index_name = 'grimoire'

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


if __name__ == "__main__":
    do_update()

