import assert from 'assert';
import { FileParser } from '../file-parser.mjs';
import { Hello } from '../file-parser.mjs';

// describe('Initial Test', function () {
//     it('should pass', function () {
//         const params = { fileName: "asdf", fileContent: "asdf" };
//         const expected = "hello, world";
//         const result = FileParser(params);
//         assert.equal(result, "hello, world");
//     });
// });




describe('Hello', function () {
    it('should say a name', function () {
        const params = { who: "Xander" };
        const expected = "Hello, Xander!";
        const result = Hello(params);
        assert.equal(expected, result);
    });
});
