import { expect, test } from 'vitest';
import { GetId } from '../src/GetId.js';


const contents1 = `#+TITLE: Example Content
#+DATE: 2022-01-01T09:23:43
#+ID: riririri3434 
#+TYPE: post

---

body content
`



test('Happy Path - Id in contents', () => {
    const fileName = 'facet- test for id.txt';
    const expected = `riririri3434`;
    const result = GetId({
        fileName: fileName,
        contents: contents1
    });
    expect(result).toBe(expected);
});
