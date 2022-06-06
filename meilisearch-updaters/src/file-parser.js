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
    return GetFacetFromFileNameDev({fileName:fileName});
    const fileParts = fileName.split(' ');
    return [fileParts[0]];
}


export function GetFacetFromFileNameDev({fileName}) {
    const fileParts = fileName.split(' ');
    const partParts = fileParts[0].split('-');
    if (partParts.length === 2) {
        return [fileParts[0]];
    }
    else {
        return [];
    }
}


