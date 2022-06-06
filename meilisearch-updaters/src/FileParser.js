export function FileParser({fileName, contents}) {
    let return_value = {
        fileName: fileName,
        title: `This Is The Title`,
        id: "aaaabbbb1212",
        contents: contents,
        facets: ['py-']
    };
    return return_value;
}
