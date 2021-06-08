#!/bin/bash

echo "queen_present|wins|draws|losses" > ../data/nbvrp_by_queens.csv

wins1=$(($(grep 'Result "1-0"' ../data/white_nbvrpqy.pgn | wc -l)+$(grep 'Result "0-1"' ../data/black_nbvrpqy.pgn | wc -l)))
draws1=$(($(grep 'Result "1/2-1/2"' ../data/white_nbvrpqy.pgn | wc -l)+$(grep 'Result "1/2-1/2"' ../data/black_nbvrpqy.pgn | wc -l)))
losses1=$(($(grep 'Result "0-1"' ../data/white_nbvrpqy.pgn | wc -l)+$(grep 'Result "1-0"' ../data/black_nbvrpqy.pgn | wc -l)))

wins2=$(($(grep 'Result "1-0"' ../data/white_nbvrpqn.pgn | wc -l)+$(grep 'Result "0-1"' ../data/black_nbvrpqn.pgn | wc -l)))
draws2=$(($(grep 'Result "1/2-1/2"' ../data/white_nbvrpqn.pgn | wc -l)+$(grep 'Result "1/2-1/2"' ../data/black_nbvrpqn.pgn | wc -l)))
losses2=$(($(grep 'Result "0-1"' ../data/white_nbvrpqn.pgn | wc -l)+$(grep 'Result "1-0"' ../data/black_nbvrpqn.pgn | wc -l)))

echo "'both'|$((wins1 + wins2))|$((draws1 + draws2))|$((losses1 + losses2))" >> ../data/nbvrp_by_queens.csv
echo "'yes'|${wins1}|${draws1}|${losses1}" >> ../data/nbvrp_by_queens.csv
echo "'no'|${wins2}|${draws2}|${losses2}" >> ../data/nbvrp_by_queens.csv