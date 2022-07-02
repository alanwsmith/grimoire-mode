#!/usr/bin/env node

import fs from 'fs';
import child_process from 'child_process';
import { FileParser } from './lib/FileParser.js';
import { MeiliSearch } from 'meilisearch'

/////////////////////////////////////////
// TODO: Move this to a config file

const rootDir = '/Users/alan/Grimoire';

const indexName = 'grimoire';

const host = 'http://127.0.0.1:7700';

const securityCall = `security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--admin-key`;

/////////////////////////////////////////


if (process.argv.length > 1) {
    const filePath = process.argv[2];
    const filePathParts = filePath.split("/");
    const fileName = filePathParts.pop();
    const fileNameParts = fileName.split('.');
    if (fileNameParts.length > 1) {
        const fileExtension = fileNameParts.pop();
        if (fileExtension === 'org') {
            if (fileNameParts[0].match(/\w/)) {
                console.log(`Updating: ${filePath}`)
                const contents = fs.readFileSync(filePath, 'utf8');
                const payload = [];
                payload[0] = FileParser({ fileName: fileName, contents: contents });
                const apiKey = child_process
                      .execSync(securityCall, { encoding: 'utf-8' })
                      .trim();
                const client = new MeiliSearch({
                    host: host,
                    apiKey: apiKey,
                });

                // delete the id to deal with
                // renames. TODO: Figure out if this
                // is a problem if the document id
                // doesn't yet. 
                client
                    .index(indexName)
                    .deleteDocument(payload[0].id)

                client
                    .index(indexName)
                    .addDocuments(payload)
                // .then((res) => console.log(res));
            }
        }
    }
}

