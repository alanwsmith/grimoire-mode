import { expect, test } from 'vitest'
import { GetId } from '../src/lib/GetId.js'

const contents1 = `#+TITLE: Example Content
#+DATE: 2022-01-01T09:23:43
#+ID: riririri3434 
#+TYPE: post

---

body content
`

test('Happy Path - Id in contents', () => {
    const fileName = 'facet- test for id.txt'
    const expected = `riririri3434`
    const result = GetId({
        fileName: fileName,
        contents: contents1,
    })
    expect(result).toBe(expected)
})

///////////////////////////////////

const contents2 = `#+TITLE: Example Content
#+DATE: 2022-01-01T09:23:43
#+TYPE: post

---

body content
`

test('GetId - no id in contents', () => {
    const fileName = 'facet- test for id.txt'
    const expected = `facettestforidtxt`
    const result = GetId({
        fileName: fileName,
        contents: contents2,
    })
    expect(result).toBe(expected)
})
