import { assert, test } from 'vitest';
import { GetFacetFromFileName } from '../src/GetFacetFromFileName.js';


test('Happy Path - One facet', () => {
    const fileName = `facet- test name.txt`;
    const expected = [`facet-`];
    const result = GetFacetFromFileName({
        fileName: fileName
    });
    assert.equal(result[0], expected[0]);
});


test('No facet in filename', () => {
    const fileName = `no facet here.txt`;
    const result = GetFacetFromFileName({
        fileName: fileName
    });
    assert.equal(result.length, 0);
});


test('One word filename', () => {
    const fileName = `nowordfilename.txt`;
    const result = GetFacetFromFileName({
        fileName: fileName
    });
    assert.equal(result.length, 0);
});


test('Filename with dashes', () => {
    const fileName = `embedded-dash.txt`;
    const result = GetFacetFromFileName({
        fileName: fileName
    });
    assert.equal(result.length, 0);
});


test('One facet from multiple dashes', () => {
    const fileName = `facet- skip- morestuff.txt`;
    const expected = ['facet-'];
    const result = GetFacetFromFileName({
        fileName: fileName
    });
    assert.equal(result[0], expected[0]);
});


