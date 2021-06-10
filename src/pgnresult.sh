#!/bin/bash
# arguments: tag
# this script finds the number of games with certain results for white and black
# and puts them in a pipe-delimited file as:
# white_wins|white_draws|white_losses\nblack_wins|black_draws|black_losses

w_win=$(grep 'Result "1-0"' ../data/pgn/white_${1}.pgn | wc -l)
w_draw=$(grep 'Result "1/2-1/2"' ../data/pgn/white_${1}.pgn | wc -l)
w_loss=$(grep 'Result "0-1"' ../data/pgn/white_${1}.pgn | wc -l)

b_win=$(grep 'Result "1-0"' ../data/pgn/black_${1}.pgn | wc -l)
b_draw=$(grep 'Result "1/2-1/2"' ../data/pgn/black_${1}.pgn | wc -l)
b_loss=$(grep 'Result "0-1"' ../data/pgn/black_${1}.pgn | wc -l)

echo "Wins|Draws|Losses" > ../data/csv/${1}_results.csv
echo "${w_win}|${w_draw}|${w_loss}" >> ../data/csv/${1}_results.csv
echo "${b_win}|${b_draw}|${b_loss}" >> ../data/csv/${1}_results.csv