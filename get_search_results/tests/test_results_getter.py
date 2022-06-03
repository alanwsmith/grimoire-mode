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

    def test_integration_basic(self):
        # given
        rg.search_term = 'example- wibble wobble'
        rg.meilisearch_response = {
            'hits': [
                'example- a.txt',
                'widget- b.txt',
                'private- c.txt',
                'example- d.txt'
            ]
        }

        # when
        rg.finalize_results()

        # then
        expected = ['example- a.txt', 'example- d.txt', 'widget- b.txt']
        results = rg.results
        self.assertEqual(expected, results)






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
        result = rg.filtered_response('example-')
        self.assertEqual(expect, result)

    def test_grouping_results(self):
        # Group all the nonce words up top
        rg.meilisearch_response = {
            "hits": [
                { "filename": "example- a.txt"},
                { "filename": "widget- c.txt"},
                { "filename": "example- b.txt"}
            ]
        }
        expect = ['example- a.txt', 'example- b.txt', 'widget- c.txt']
        result = rg.filtered_response('example-')
        self.assertEqual(expect, result)

    def test_remove_private_files(self):
        # given
        rg.results = [
            'example- a.txt',
            'private- b.txt',
            'widget- c.txt'
        ]
        rg.tokens_to_exclude = ['private-']
        # when
        rg.remove_exclusions()
        # then
        expect = ['example- a.txt', 'widget- c.txt']
        result = rg.results
        self.assertEqual(expect, result)



if __name__ == "__main__":
    print(datetime.now())
    print("\n\n")
    unittest.main()

