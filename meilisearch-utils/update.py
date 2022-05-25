#!/usr/bin/env python3

import glob
import hashlib
import json
import keyring
import meilisearch
import os

def string_to_md5(string):
    return hashlib.md5(bytes(string, encoding="utf-8")).hexdigest()

def list_dir(*, root_dir, sub_dir=''):
    return_value = []
    root_dir_full = os.path.realpath(os.path.join(root_dir))
    dir_to_process = os.path.join(root_dir_full, sub_dir)

    file_list = [
        file for file in glob.glob(
            f"{dir_to_process}/*"
        )
        if os.path.isfile(file)
    ]

    for file in file_list:
        name_with_extension = os.path.basename(file)
        name_without_extension = os.path.splitext(name_with_extension)[0]
        extension = os.path.splitext(name_with_extension)[1].replace('.', '')

        return_value.append(
            {
                "root_dir": root_dir_full,
                "sub_dir": sub_dir,
                "name_with_extension": name_with_extension,
                "name_without_extension": name_without_extension,
                "extension": extension,
                "full_path": file
            }
        )


    sub_dir_list = [
        directory for directory in glob.glob(
            f"{dir_to_process}/*"
        )
        if os.path.isdir(directory)
    ]

    for sub_dir_full_path in sub_dir_list:
        base_sub_dir = sub_dir_full_path.replace(f'{root_dir_full}/', '')
        tmp_list = list_dir(root_dir=root_dir_full, sub_dir=base_sub_dir)
        for item in tmp_list:
            return_value.append(item)


    return return_value


def update_files():

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




  file_list = list_dir(
      # root_dir='/Users/alan/workshop/grimoire-mode/samples/set-3'
      root_dir='/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Grimoire'
  )

  documents = []

  print("Prepping Documents")
  for file_item in file_list:
      with open(file_item['full_path'], 'r', encoding='utf-8', errors='ignore') as _in:
          if file_item['extension'] == 'txt':
              content = json.dumps(_in.read())
              new_item = {
                  "id": string_to_md5(file_item['name_with_extension']),
                  "filename": file_item['name_with_extension'],
                  "content": content
              }
              documents.append(new_item)

  print("Deleting index")
  response_delete = client.index(index_name).delete()

  print("Uploading data")
  response_upload = client.index(index_name).add_documents(documents)

  print(response_upload)


if __name__ == "__main__":
    print("Starting update")
    update_files()
    print("Process complete")

