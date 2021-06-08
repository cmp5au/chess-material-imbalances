#!/bin/bash
# arguments: tag pgn-to-check-against
# for example, to get the 2013 & 2014 blitz games with the bishop pair, run: $ bash process_tag.sh tags/bpvnp ../data/2013-2014-blitz.pgn
# This script requires the tag to be formatted for White
pgn-extract -s -z tags/$1 $2 | pgn-extract -s -y tags/$1 -o../data/white_${1}.pgn -n../data/black_${1}.pgn