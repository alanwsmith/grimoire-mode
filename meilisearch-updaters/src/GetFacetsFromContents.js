export function GetFacetsFromContents (params) {

    const facets = [];
    const lines = params.contents.split("\n");
    const pattern = /#\+FACET: (.*)/;

    lines.forEach((line) => {
        const match = line.match(pattern);
        if (match != null) {
            facets.push(match[1].trim());
        }
    });

    return facets;
}
