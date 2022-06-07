#!/usr/bin/env node

import fs from 'fs';
import child_process from 'child_process';
import { ListDir } from './lib/ListDir.js';
import { FileParser } from './lib/FileParser.js';
import { MeiliSearch } from 'meilisearch';

// console.log("------------------ START UPDATE ------------------");

const fileList = ListDir(
    '/Users/alan/workshop/grimoire-mode/meilisearch-updaters/sample_files'
);

const payload = [];

fileList.forEach((file) => {
    try {
        const contents = fs.readFileSync(file.full_path, 'utf8');
        const details = FileParser({fileName: file.name, contents: contents });
        payload.push(details);
    } catch (err) {
        console.error(err);
    }
});

const securityCall = `security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--admin-key`;

const apiKey = child_process.execSync(securityCall, {encoding: 'utf-8'}).trim();

const client = new MeiliSearch({ host: 'http://127.0.0.1:7700', apiKey: apiKey });

client.index('test-samples').addDocuments(payload).then((res) => console.log(res));
console.log(payload);
