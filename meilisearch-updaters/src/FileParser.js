import { GetFacetFromFileName } from './GetFacetFromFileName.js';
import { GetFacetsFromContents } from './GetFacetsFromContents.js';
import { GetTitleFromContents } from './GetTitleFromContents.js';
import { GetId } from './GetId.js';

export function FileParser(params) {
    const facets = [];
    const fileNameFacet = GetFacetFromFileName(params);
    if(fileNameFacet !== null) {
        facets.push(fileNameFacet);
    }
    const contentFacets = GetFacetsFromContents(params);
    contentFacets.forEach((contentFacet) => {
        facets.push(contentFacet);
    });

    let return_value = {
        fileName: params.fileName,
        title: GetTitleFromContents(params),
        id: GetId(params),
        contents: params.contents,
        facets: facets
    };
    return return_value;
}


