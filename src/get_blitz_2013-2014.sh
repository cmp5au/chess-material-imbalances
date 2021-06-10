#!/bin/bash
# code to download .bz2 files, unzip them, grab only the blitz games
# played in 2013 or 2014 by players between 1200 and 2000 elo,
# and store them in a common .pgn file
# without saving any of the intermediate results in order to save disk space

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
    curl "$u" | pbzip2 -d | pgn-extract -s -t tags/blitzgames | pgn-extract -s -t tags/nomaster >> ../data/pgn/2013-2014-blitz.pgn
done