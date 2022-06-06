import { assert, test } from 'vitest';
import { FileParser } from '../src/file-parser.js';
import { GetFacetFromFileName } from '../src/file-parser.js';
import { GetFacetFromFileNameDev } from '../src/file-parser.js';

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

test('Integration - Happy path with basic filename', () => {
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


test('GetFacetFromFileName - One facet', () => {
    const fileName = `facet- test name.txt`;
    const expected = [`facet-`];
    const result = GetFacetFromFileName({
        fileName: fileName
    });
    assert.equal(expected[0], result[0]);
});


test('GetFacetFromFileName - One facet', () => {
    const fileName = `no facet here test name.txt`;
    const result = GetFacetFromFileNameDev({
        fileName: fileName
    });
    assert.equal(0, result.length);
});




        // it(`should have no facets if the first word isn't one`, function () {
        //     const fileName = `no facet here test name.txt`;
        //     const result = GetFacetFromFileNameDev({
        //         fileName: fileName
        //     });
        //     assert.equal(0, result.length);
        // });


// describe('Integration Tests', function () {
//     it('should work', function () {
//         const fileName = "py- regex test one.txt";
//         const expected = {
//             fileName: fileName,
//             id: "1ka6lw9Ec9Tb",
//             contents: contents1,
//             facets: ['py-']
//         };
//         const result = FileParser({
//             fileName: fileName,
//             contents: contents1
//         });
//         assert.equal(expected.fileName, result.fileName);
//         assert.equal(expected.id, result.id);
//         assert.equal(expected.contents, result.contents);
//         assert.equal(expected.facets[0], result.facets[0]);
//     });
// });


// describe('File name facet finder', function() {
//     it('should find a facet', function () {
//         const fileName = `facet- test name.txt`;
//         const expected = [`facet-`];
//         const result = GetFacetFromFileName({
//             fileName: fileName
//         });
//         assert.equal(expected[0], result[0]);
//     });
//     it(`should have no facets if the first word isn't one`, function () {
//         const fileName = `no facet here test name.txt`;
//         const result = GetFacetFromFileNameDev({
//             fileName: fileName
//         });
//         assert.equal(0, result.length);
//     });
// });




         // TODO:
         // `facet- seoncdone- see if you want that.txt`
         // `single_word.txt`
