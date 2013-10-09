#!env python
import json
import sys
import pprint

pp = pprint.PrettyPrinter(indent=4)

o = json.loads(sys.stdin.read())
pp.pprint(o)
