#!/usr/bin/env python3 

import os
import sys
import unittest

from datetime import datetime

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from results_getter.results_getter import ResultsGetter

class ResultsGetterTest(unittest.TestCase):

    def setUp(self):
        global rg
        rg = ResultsGetter()

    def test_ready_for_no_results(self):
        expect = "Ready..."
        result = rg.search("")
        self.assertEqual(expect, result)

    def test_basic_results(self):
        rg.meilisearch_response = {
            "hits": [
                { "filename": "example- a.txt"},
                { "filename": "example- b.txt"},
                { "filename": "widget- c.txt"}
            ]
        }
        expect = ['example- a.txt', 'example- b.txt', 'widget- c.txt']
        result = ['example- a.txt', 'example- b.txt', 'widget- c.txt']
        result = rg.filtered_response()
        self.assertEqual(expect, result)









if __name__ == "__main__":
    print(datetime.now())
    unittest.main()

