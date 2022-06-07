import { assert, test } from 'vitest';
import { FileParser } from '../src/FileParser.js';


// This is the main integration test


test('Integration - Happy path with basic filename', () => {
    const fileName = "py- regex test one.txt";
    const contents = `
#+TITLE: This Is The Title
#+DATE: 2020-11-20T21:41:42
#+ID: aaaabbbb1212
#+CATEGORY: Python
#+STATUS: published
#+TYPE: post
#+FACET: testing- 

---

This is some content.
`;
    const expected = {
        fileName: fileName,
        title: `This Is The Title`,
        id: "aaaabbbb1212",
        contents: contents,
        facets: ['py-', 'testing-']
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
    assert.equal(expected.facets[1], result.facets[1]);
    assert.equal(expected.title, result.title);
});
