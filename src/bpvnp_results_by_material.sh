#!/bin/bash
# creates a pipe-delimited CSV in /data/csv/ to be read into a Pandas DataFrame

# header line of CSV:
echo "material|wins|draws|losses" > ../data/csv/bpvnp_by_material.csv

#33 points of material
cat ../data/pgn/white_bpvnp.pgn ../data/pgn/black_bpvnp.pgn | pgn-extract -s -z tags/bpvnpraw0 -otmp0 -nret0
pgn-extract -s -y tags/bpvnpraw0 -owhite0 -nblack0 tmp0
win=$(($(grep 'Result "1-0"' white0 | wc -l)+$(grep 'Result "0-1"' black0 | wc -l)))
draw=$(($(grep 'Result "1/2-1/2"' white0 | wc -l)+$(grep 'Result "1/2-1/2"' black0 | wc -l)))
loss=$(($(grep 'Result "0-1"' white0 | wc -l)+$(grep 'Result "1-0"' black0 | wc -l)))
echo "33|${win}|${draw}|${loss}" >> ../data/csv/bpvnp_by_material.csv
rm tmp0 white0 black0

#32 points of material
pgn-extract -s -z tags/bpvnpraw1 -otmp1 -nret1 ret0
pgn-extract -s -y tags/bpvnpraw1 -owhite1 -nblack1 tmp1
win=$(($(grep 'Result "1-0"' white1 | wc -l)+$(grep 'Result "0-1"' black1 | wc -l)))
draw=$(($(grep 'Result "1/2-1/2"' white1 | wc -l)+$(grep 'Result "1/2-1/2"' black1 | wc -l)))
loss=$(($(grep 'Result "0-1"' white1 | wc -l)+$(grep 'Result "1-0"' black1 | wc -l)))
echo "32|${win}|${draw}|${loss}" >> ../data/csv/bpvnp_by_material.csv
rm ret0 tmp1 white1 black1

#31 points of material
pgn-extract -s -z tags/bpvnpraw2 -otmp2 -nret2 ret1
pgn-extract -s -y tags/bpvnpraw2 -owhite2 -nblack2 tmp2
win=$(($(grep 'Result "1-0"' white2 | wc -l)+$(grep 'Result "0-1"' black2 | wc -l)))
draw=$(($(grep 'Result "1/2-1/2"' white2 | wc -l)+$(grep 'Result "1/2-1/2"' black2 | wc -l)))
loss=$(($(grep 'Result "0-1"' white2 | wc -l)+$(grep 'Result "1-0"' black2 | wc -l)))
echo "31|${win}|${draw}|${loss}" >> ../data/csv/bpvnp_by_material.csv
rm ret1 tmp2 white2 black2

#30 points of material
pgn-extract -s -z tags/bpvnpraw3 -otmp3 -nret3 ret2
pgn-extract -s -y tags/bpvnpraw3 -owhite3 -nblack3 tmp3
win=$(($(grep 'Result "1-0"' white3 | wc -l)+$(grep 'Result "0-1"' black3 | wc -l)))
draw=$(($(grep 'Result "1/2-1/2"' white3 | wc -l)+$(grep 'Result "1/2-1/2"' black3 | wc -l)))
loss=$(($(grep 'Result "0-1"' white3 | wc -l)+$(grep 'Result "1-0"' black3 | wc -l)))
echo "30|${win}|${draw}|${loss}" >> ../data/csv/bpvnp_by_material.csv
rm ret2 tmp3 white3 black3

#29 points of material
pgn-extract -s -z tags/bpvnpraw4 -otmp4 -nret4 ret3
pgn-extract -s -y tags/bpvnpraw4 -owhite4 -nblack4 tmp4
win=$(($(grep 'Result "1-0"' white4 | wc -l)+$(grep 'Result "0-1"' black4 | wc -l)))
draw=$(($(grep 'Result "1/2-1/2"' white4 | wc -l)+$(grep 'Result "1/2-1/2"' black4 | wc -l)))
loss=$(($(grep 'Result "0-1"' white4 | wc -l)+$(grep 'Result "1-0"' black4 | wc -l)))
echo "29|${win}|${draw}|${loss}" >> ../data/csv/bpvnp_by_material.csv
rm ret3 tmp4 white4 black4

#28 or fewer points of material
pgn-extract -s -z tags/bpvnp -owhiterest -nblackrest ret4
win=$(($(grep 'Result "1-0"' whiterest | wc -l)+$(grep 'Result "0-1"' blackrest | wc -l)))
draw=$(($(grep 'Result "1/2-1/2"' whiterest | wc -l)+$(grep 'Result "1/2-1/2"' blackrest | wc -l)))
loss=$(($(grep 'Result "0-1"' whiterest | wc -l)+$(grep 'Result "1-0"' blackrest | wc -l)))
echo "28|${win}|${draw}|${loss}" >> ../data/csv/bpvnp_by_material.csv
rm ret4 whiterest blackrest