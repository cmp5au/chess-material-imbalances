#!/bin/bash
urls=""
for i in 2013 2014
do
    for j in {1..9}
    do
        urls+=" https://database.lichess.org/standard/lichess_db_standard_rated_${i}-0${j}.pgn.bz2"
    done
    for j in 10 11 12
    do
        urls+=" https://database.lichess.org/standard/lichess_db_standard_rated_${i}-${j}.pgn.bz2"
    done
done

# strip the leading space character
urls=${urls:1}

for u in $urls
do
    curl "$u" | pbzip2 -d | pgn-extract -s -t tags/blitzgames | pgn-extract -s -t tags/nomaster >> ../data/2013-2014-blitz.pgn
done