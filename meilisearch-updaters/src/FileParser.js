import { GetFacetFromFileName } from './GetFacetFromFileName.js';
import { GetTitleFromContents } from './GetTitleFromContents.js';

export function FileParser(params) {
    const facets = [];
    const fileNameFacet = GetFacetFromFileName(params);
    if(fileNameFacet !== null) {
        facets.push(fileNameFacet);
    }

    let return_value = {
        fileName: params.fileName,
        title: GetTitleFromContents(params),
        id: "aaaabbbb1212",
        contents: params.contents,
        facets: facets 
    };
    return return_value;
}
