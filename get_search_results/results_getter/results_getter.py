import re

class ResultsGetter:

    def __init__(self):
        self.meilisearch_response = {}

    def search(self, term):
        return "Ready..."

    def filtered_response(self, term):
        return_list = []
        secondary_return_list = []
        for candidate in self.meilisearch_response['hits']:
            if re.match(term, candidate['filename']):
                return_list.append(candidate['filename'])
            else:
                secondary_return_list.append(candidate['filename'])
        return_list.extend(secondary_return_list)
        return return_list
