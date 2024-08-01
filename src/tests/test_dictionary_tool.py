import unittest
import sys
import os

# Adiciona o diretório src ao sys.path
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), 'src')))

from dictionary_tool import get_definition

class TestDictionaryTool(unittest.TestCase):
    def test_get_definition(self):
        result = get_definition('exercise')
        expected_substring = 'the act of bringing into play'
        self.assertIn(expected_substring, result)

if __name__ == '__main__':
    unittest.main()

