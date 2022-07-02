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


    def test_integration_generate_results(self):
        rg.search_term = 'example- wibble wobble'
        rg.exclusions = ['private-']
        rg.meilisearch_response = {
            'hits': [
                { 'filename': 'example- a.txt'},
                { 'filename': 'widget- b.txt'},
                { 'filename': 'private- c.txt'},
                { 'filename': 'example- d.txt'}
            ]
        }
        rg.generate_results()
        expected = ['example- a.txt', 'example- d.txt', 'widget- b.txt']
        results = rg.results
        self.assertEqual(expected, results)


    def test_integration_empty_search_term(self):
        rg.search_term = ''
        rg.exclusions = ['private-']
        rg.meilisearch_response = {
            'hits': []
        }
        rg.generate_results()
        expected = ['Ready...']
        results = rg.results
        self.assertEqual(expected, results)


    def test_integration_only_one_character_in_search_term(self):
        # NOTE: This probably won't get hit in prod
        # since the process will bail before this is
        # called. 
        rg.search_term = 'a'
        rg.exclusions = ['private-']
        rg.meilisearch_response = {
            'hits': [
                { 'filename': 'example- a.txt'},
                { 'filename': 'widget- b.txt'},
                { 'filename': 'private- c.txt'},
                { 'filename': 'example- d.txt'}
            ]
        }
        rg.generate_results()
        expected = ['Ready...']
        results = rg.results
        self.assertEqual(expected, results)


    def test_intregration_without_nonce(self):
        rg.search_term = 'test'
        rg.exclusions = ['private-']
        rg.meilisearch_response = {
            'hits': [
                { 'filename': 'example- test 6.txt'},
                { 'filename': 'widget- test 7.txt'},
                { 'filename': 'private- test 8.txt'},
                { 'filename': 'example- test 9.txt'}
            ]
        }
        rg.generate_results()
        expected = ['example- test 6.txt', 'widget- test 7.txt', 'example- test 9.txt']
        results = rg.results
        self.assertEqual(expected, results)


    def test_load_nonce(self):
        rg.search_term = 'example- wibble wobble'
        rg.load_nonce()
        expected = 'example-'
        results = rg.nonce
        self.assertEqual(expected, results)


    def test_parse_meilisearch_results(self):
        rg.meilisearch_response = {
            'hits': [
                { 'filename': 'example- a.txt'},
                { 'filename': 'widget- b.txt'},
                { 'filename': 'private- c.txt'},
                { 'filename': 'example- d.txt'}
            ]
        }
        rg.parse_meilisearch_results()
        expected = ['example- a.txt', 'widget- b.txt', 'private- c.txt', 'example- d.txt']
        results = rg.results
        self.assertEqual(expected, results)


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


    def test_sort_results(self):
        rg.nonce = 'example-'
        rg.results = [ 'example- a.txt', 'widget- c.txt', 'example- b.txt' ]
        rg.sort_results()
        expect = ['example- a.txt', 'example- b.txt', 'widget- c.txt']
        result = rg.results
        self.assertEqual(expect, result)


    def test_sort_results_with_empty_nonce(self):
        rg.nonce = ''
        rg.results = [ 'example- a.txt', 'widget- c.txt', 'example- b.txt' ]
        rg.sort_results()
        expect = ['example- a.txt', 'widget- c.txt', 'example- b.txt']
        result = rg.results
        self.assertEqual(expect, result)


    def test_remove_exclusions(self):
        rg.results = [
            'example- a.txt',
            'private- b.txt',
            'widget- c.txt'
        ]
        rg.exclusions = ['private-']
        rg.remove_exclusions()
        expect = ['example- a.txt', 'widget- c.txt']
        result = rg.results
        self.assertEqual(expect, result)



if __name__ == "__main__":
    print(datetime.now())
    print("\n\n")
    unittest.main()

