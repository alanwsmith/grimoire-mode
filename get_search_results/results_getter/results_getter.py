class ResultsGetter:

    def __init__(self):
        self.meilisearch_response = {}

    def search(self, term):
        return "Ready..."

    def filtered_response(self):


        return_value = []
        for candidate in self.meilisearch_response['hits']:
            return_value.append(candidate['filename'])
            # print(candidate)


        # return_value = [
        #     'example- a.txt',
        #     'example- b.txt',
        #     'widget- c.txt'
        # ]

        return return_value 
