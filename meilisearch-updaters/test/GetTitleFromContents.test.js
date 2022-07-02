import { expect, test } from 'vitest';
import { GetTitleFromContents } from '../src/lib/GetTitleFromContents.js';



/////////////////////////////////////////////

const contents1 = `#+TITLE: Quick Brown Fox 
#+DATE: 2022-01-01T04:34:23

---

body of text`;

//

test('GetTitleFromContents - one title - happy path', () => {
    const expected = `Quick Brown Fox`;
    const result = GetTitleFromContents({
        contents: contents1
    });
    expect(result).toBe(expected);
});


/////////////////////////////////////////////

const contents2 = `#+DATE: 2022-01-01T04:34:23

---

body of text`;

//

test('GetTitleFromContents - no title', () => {
    const expected = null;
    const result = GetTitleFromContents({
        contents: contents2
    });
    expect(result).toBe(expected);
});




/////////////////////////////////////////////

const contents3 = `#+TITLE: First Title
#+DATE: 2022-01-01T04:34:23
#+TITLE: Second Title

---

body of text`;

//

test('GetTitleFromContents - two titles - only show one', () => {
    const expected = `First Title`;
    const result = GetTitleFromContents({
        contents: contents3
    });
    expect(result).toBe(expected);
});


