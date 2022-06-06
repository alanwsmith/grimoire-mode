export function FileParser({fileName, contents}) {
    let return_value = {
        fileName: fileName,
        id: "1ka6lw9Ec9Tb",
        contents: contents,
        facets: ['py-']
    };
    return return_value;
}


export function GetFacetFromFileName({fileName}) {
    const fileParts = fileName.split(' ');
    return [fileParts[0]];
}
