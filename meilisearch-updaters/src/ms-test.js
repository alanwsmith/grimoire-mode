#!/usr/bin/env node

import child_process from 'child_process';
import { MeiliSearch } from 'meilisearch'
import movies from './movies.json'

const securityCall = `security find-generic-password -w -a alan -s alan--meilisearch--scratchpad--admin-key`;

const apiKey = child_process.execSync(securityCall, {encoding: 'utf-8'}).trim();

const client = new MeiliSearch({ host: 'http://127.0.0.1:7700', apiKey: apiKey })
client.index('movie').addDocuments(movies)
    .then((res) => console.log(res))


