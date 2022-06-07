export function GetFacetFromFileName(params) {
    const fileParts = params.fileName.split(' ');
    if (fileParts.length === 1) {
        return null;
    }
    else {
        const partParts = fileParts[0].split('-');
        if (partParts.length === 2) {
            return fileParts[0];
        }
        else {
            return null;
        }
    }
}
