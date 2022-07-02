export function GetId(params) {
    const lines = params.contents.split("\n");
    const pattern = /#\+ID: (.*)/;
    for (const line of lines) {
        const match = line.match(pattern);
        if (match !== null) {
            return match[1].trim();
        }
    }
    // If you're here there was no id
    // in the content. Just using the
    // file name for the id
    return params.fileName.replace(/\W/g, '');
}



