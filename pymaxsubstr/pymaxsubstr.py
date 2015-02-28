
#   Stdlib
import os
import math
import collections
import pdb
import subprocess
import atexit
import traceback
from pprint import pformat

#   3rd party
import marisa_trie

#   Custom
from ..lib.pysais.pysais import get_maxsubst
from .constants_tasks import THIS_DIR

def main():
	"""
	TBD
	"""


def substrs_to_trie(names):
	name_str = u' '.join(names)
	trie = marisa_trie.Trie(get_substrs(name_str))
	return trie


def load_trie(path):
	return marisa_trie.Trie().load(path)


def get_substrs(s):
	substrs = get_maxsubst(s)
	return filter_substrs(substrs)


def filter_substrs(substrs):
	substrs = ( substr.strip() for substr in substrs )
	substrs = ( substr for substr in substrs if len(substr) > 1 )
	substrs = ( substr for substr in substrs if u' ' not in substr )
	substrs = sorted(list(set(substrs)))
	return substrs


def extract_features(st, trie):
	#   ===============================================
	def find_substrs(st, i, l):
		for j in range(i, l):
			prefix = st[i : j+1]
			if not trie.has_keys_with_prefix(prefix):
				break
			if prefix in trie and len(prefix) > 1:
				yield prefix
	#   ===============================================
	events_by_text = collections.Counter()
	l = len(st)
	for i in range(l):
		substrs = find_substrs(st, i, l)
		for p in substrs:
			events_by_text[p] += 1
	return events_by_text


if __name__ == '__main__':
		main()
