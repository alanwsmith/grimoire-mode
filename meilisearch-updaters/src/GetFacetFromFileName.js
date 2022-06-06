export function GetFacetFromFileName({fileName}) {
    const fileParts = fileName.split(' ');
    if (fileParts.length === 1) {
        return [];
    }
    else {
        const partParts = fileParts[0].split('-');
        if (partParts.length === 2) {
            return [fileParts[0]];
        }
        else {
            return [];
        }
    }
}
