export function GetId(params) {
    const lines = params.contents.split("\n");
    const pattern = /#\+ID: (.*)/;
    for (const line of lines) {
        const match = line.match(pattern);
        if (match !== null) {
            return match[1].trim();
        }
    }
}



