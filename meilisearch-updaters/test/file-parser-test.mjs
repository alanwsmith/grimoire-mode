import assert from 'assert';
import { FileParser } from '../file-parser.mjs';


const contents1 = `
#+TITLE: This Is The Title 
#+DATE: 2020-11-20T21:41:42
#+ID: 1ka6lw9Ec9Tb
#+CATEGORY: Python 
#+STATUS: published 
#+TYPE: post

---

This is some content.
`;

describe('Integration Tests', function () {
    it('should work', function () {
        const fileName = "py- regex test one.txt";
        const expected = {
            fileName: fileName,
            id: "1ka6lw9Ec9Tb",
            contents: contents1,
            facets: ['py-']
        };
        const result = FileParser({
            fileName: fileName,
            contents: contents1
        });
        assert.equal(expected.fileName, result.fileName);
        assert.equal(expected.id, result.id);
        assert.equal(expected.contents, result.contents);
        assert.equal(expected.facets[0], result.facets[0]);
    });
});


