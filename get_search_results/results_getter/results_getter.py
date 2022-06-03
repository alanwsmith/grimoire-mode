import re

class ResultsGetter:

    # TODO: Setup to pull nonce_words_to_exclude
    # via a config
    # NOTE: private tokens are only parsed out
    # of the retunred filenames, not the contents
    # of the files themselves. 

    def __init__(self):
        self.search_term = ""
        self.meilisearch_response = {}
        self.return_list = []
        self.results = []
        self.tokens_to_exclude = []
        self.nonce = None

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

    def remove_exclusions(self):
        filtered_results = []
        for item in self.results:
            keep_it = True
            for private_term in self.tokens_to_exclude:
                if private_term in item:
                    keep_it = False
            if keep_it == True:
                filtered_results.append(item)
        self.results = filtered_results

    def finalize_results(self):
        self.results = ['example- a.txt', 'example- d.txt', 'widget- b.txt']
