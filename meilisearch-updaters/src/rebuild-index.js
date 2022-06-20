#!/usr/bin/env node

import fs from 'fs'
import child_process from 'child_process'
import { ListDir } from './lib/ListDir.js'
import { FileParser } from './lib/FileParser.js'
import { MeiliSearch } from 'meilisearch'

// console.log("------------------ START UPDATE ------------------");

/////////////////////////////////////////
// Setup
// TODO: Move this to a config file

const fileList = ListDir(
    // '/Users/alan/workshop/grimoire-mode/meilisearch-updaters/sample_files'
    '/Users/alan/Grimoire'
)

const indexName = 'grimoire'

const host = 'http://127.0.0.1:7700'

const securityCall = `security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--admin-key`

/////////////////////////////////////////

const payload = []

fileList.forEach((file) => {
    try {
        const contents = fs.readFileSync(file.full_path, 'utf8')
        const details = FileParser({ fileName: file.name, contents: contents })
        payload.push(details)
        // console.log(details)
    } catch (err) {
        // console.error(err)
    }
})

const apiKey = child_process
    .execSync(securityCall, { encoding: 'utf-8' })
    .trim()

const client = new MeiliSearch({
    host: host,
    apiKey: apiKey,
})

client
    .index(indexName)
    .deleteAllDocuments()

client
    .index(indexName)
    .addDocuments(payload)
    // .then((res) => console.log(res))

client
    .index(indexName)
    .updateFilterableAttributes([
        'facets'
    ])
