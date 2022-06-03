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
        self.exclusions = []
        self.nonce = ''

    def search(self, term):
        return "Ready..."

    # TODO: Remove this in favore of indiviual
    # funciton
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

    def load_nonce(self):
        match = re.match(r'^(\w+-) ', self.search_term)
        if match:
            self.nonce = match[1]


    def parse_meilisearch_results(self):
        parsed_results = []
        for hit in self.meilisearch_response['hits']:
            parsed_results.append(hit['filename'])
        self.results = parsed_results


    def remove_exclusions(self):
        filtered_results = []
        for item in self.results:
            keep_it = True
            for private_term in self.exclusions:
                if private_term in item:
                    keep_it = False
            if keep_it == True:
                filtered_results.append(item)
        self.results = filtered_results


    def sort_results(self):
        primary_list = []
        secondary_list = []
        for result in self.results:
            if re.match(self.nonce, result):
                primary_list.append(result)
            else:
                secondary_list.append(result)
        self.results = primary_list + secondary_list


    def generate_results(self):
        if self.search_term == '':
            self.results = ['Ready...']
        else:
            self.load_nonce()
            self.parse_meilisearch_results()
            self.sort_results()
            self.remove_exclusions()

        # TODO: remove the hard coded test stub here
        # self.results = ['example- a.txt', 'example- d.txt', 'widget- b.txt']


        # self.results = ['example- a.txt', 'example- b.txt', 'widget- c.txt']

    # def filtered_response_dev(self, term):
    #     # return_list = ['widget- c.txt', 'example- b.txt'] 
    #     # return return_list
    #     return_list = []
    #     secondary_return_list = []
    #     for candidate in self.meilisearch_response['hits']:
    #         is_private = False
    #         for private_term in self.nonce_words_to_exclude:
    #             if private_term in candidate['filename']:
    #                 is_private = True
    #         if is_private == False:
    #             if re.match(term, candidate['filename']):
    #                 return_list.append(candidate['filename'])
    #             else:
    #                 secondary_return_list.append(candidate['filename'])
    #     return_list.extend(secondary_return_list)
    #     return return_list



if __name__ == '__main__':
    # load the search term from the arg
    # load exclusions from config
    # get the meilisearch respose
    # run generate_results()
    # output the response via print
    pass
