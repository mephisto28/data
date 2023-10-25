#! /usr/bin/python3

import sys
import collections

id_count = collections.Counter()
id_idx = {}
input_list = sys.argv[1]
prefix = sys.argv[2]
for line in open(input_list):
    k = line.strip()
    id = k.split('/')[5]
    if id not in id_idx:
        id_idx[id] = len(id_idx)
    print(k + "\t%s%014d_P%d" % (prefix, id_idx[id], id_count[id]) )
    id_count[id] += 1