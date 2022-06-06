import { assert, test } from 'vitest';
import { FileParser } from '../src/FileParser.js';

test('Integration - Happy path with basic filename', () => {
    const fileName = "py- regex test one.txt";
    const contents = `
#+TITLE: This Is The Title 
#+DATE: 2020-11-20T21:41:42
#+ID: 1ka6lw9Ec9Tb
#+CATEGORY: Python 
#+STATUS: published 
#+TYPE: post

---

This is some content.
`;
    const expected = {
        fileName: fileName,
        id: "1ka6lw9Ec9Tb",
        contents: contents,
        facets: ['py-']
    };
    const result = FileParser({
        fileName: fileName,
        contents: contents
    });
    // TODO: Swithc this order to result/expected
    // to match error messages.
    assert.equal(expected.fileName, result.fileName);
    assert.equal(expected.id, result.id);
    assert.equal(expected.contents, result.contents);
    assert.equal(expected.facets[0], result.facets[0]);
});
