import re

from pathlib import Path

history_file_path = "/Users/alan/.config/grimoire-mode/search-history.txt"


class ResultsGetter:

    # NOTE: exclusions are only taken out
    # of the returned fileNames, not the contents
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
            if re.match(term, candidate['fileName']):
                return_list.append(candidate['fileName'])
            else:
                secondary_return_list.append(candidate['fileName'])
        return_list.extend(secondary_return_list)
        return return_list

    def load_nonce(self):
        match = re.match(r'^(\w+-) ', self.search_term)
        if match:
            self.nonce = match[1]


    def parse_meilisearch_results(self):
        parsed_results = []
        for hit in self.meilisearch_response['hits']:
            parsed_results.append(hit['fileName'])
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
        # TODO: Handle if this history file doesn't exist
        history = []
        with open (history_file_path) as _history:
            tmp_history = _history.readlines()
            for item in tmp_history:
                # TODO: Setup the grimoire directory in a config variable
                full_path = f"/Users/alan/Grimoire/{item}".strip()
                if Path(full_path).is_file():
                    if item not in history:
                        history.append(item)

        # write the updated history file back out
        with open (history_file_path, 'w') as _history_out:
            _history_out.write("".join(history[0:15]))

        if self.search_term == '':
            self.results = ['Ready...']
            self.results = history
        elif len(self.search_term) == 1:
            self.results = ['Ready...']
            self.results = history
        else:
            self.load_nonce()
            self.parse_meilisearch_results()
            self.sort_results()
            self.remove_exclusions()

