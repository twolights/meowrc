#!env python
import json
import sys

o = json.loads(sys.stdin.read())
print json.dumps(o, indent=4)
