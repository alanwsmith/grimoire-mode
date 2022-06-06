import { expect, test } from 'vitest';
import { GetTitleFromContents } from '../src/GetTitleFromContents.js';






test('GetTitleFromContents - one title - happy path', () => {
    const contents = `#+TITLE: Quick Brown Fox
#+DATE: 2022-01-01T04:34:23

---

body of text`;

    const expected = `Quick Brown Fox`;
    const result = GetTitleFromContents({
        contents: contents
    });
    expect(result).toBe(expected);
});





test('GetTitleFromContents - no title', () => {
    const contents = `#+DATE: 2022-01-01T04:34:23

---

body of text`;

    const expected = null;
    const result = GetTitleFromContents({
        contents: contents
    });
    expect(result).toBe(expected);
});




// TODO:

// No title
// Multiple titles
