import { expect, test } from 'vitest';
import { GetFacetsFromContents } from '../src/lib/GetFacetsFromContents.js';


const contents1 = `#+TITLE: Document Title
#+DATE: 2022-01-01T08:23:43
#+FACET: inline1-
#+FACET: second- 

---

body content
`

test('Happy Path - One facet', () => {
    const expected = ['inline1-', 'second-'];
    const result = GetFacetsFromContents({
        contents: contents1
    });
    expect(result[0]).toBe(expected[0]);
    expect(result[1]).toBe(expected[1]);
});
