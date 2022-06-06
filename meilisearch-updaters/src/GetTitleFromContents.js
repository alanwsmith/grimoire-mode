export function GetTitleFromContents (params) {
    let title = null;
    const lines = params.contents.split("\n");
    const pattern = /#\+TITLE: (.*)/;
    for (const line of lines) {
        const match = line.match(pattern);
        if (match !== null) {
            return match[1];
        }
    }
    return null;
}
