import { expect, test } from 'vitest';
import { GetFacetFromFileName } from '../src/lib/GetFacetFromFileName.js';


test('Happy Path - One facet', () => {
    const fileName = `facet- test name.txt`;
    const expected = `facet-`;
    const result = GetFacetFromFileName({
        fileName: fileName
    });
    expect(result).toBe(expected);
});


test('No facet in filename', () => {
    const fileName = `no facet here.txt`;
    const expected = null;
    const result = GetFacetFromFileName({
        fileName: fileName
    });
    expect(result).toBe(expected);
});


test('One word filename', () => {
    const fileName = `nowordfilename.txt`;
    const expected = null;
    const result = GetFacetFromFileName({
        fileName: fileName
    });
    expect(result).toBe(expected);
});


test('Filename with dashes', () => {
    const fileName = `embedded-dash.txt`;
    const expected = null;
    const result = GetFacetFromFileName({
        fileName: fileName
    });
    expect(result).toBe(expected);
});


test('One facet from multiple dashes', () => {
    const fileName = `facet- skip- morestuff.txt`;
    const expected = `facet-`;
    const result = GetFacetFromFileName({
        fileName: fileName
    });
    expect(result).toBe(expected);
});


