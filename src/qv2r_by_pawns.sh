#!/bin/bash

echo "num_pawns|wins|draws|losses" > ../data/qv2r_by_pawns.csv

cat ../data/white_qv2r.pgn ../data/black_qv2r.pgn > all_qv2r.pgn
pgn-extract -s -z tags/qv2r8p -otmp8 -nret8 all_qv2r.pgn
pgn-extract -s -y tags/qv2r8p -owhite8 -nblack8 tmp8

pgn-extract -s -z tags/qv2r7p -otmp7 -nret7 ret8
pgn-extract -s -y tags/qv2r7p -owhite7 -nblack7 tmp7

wins8=$(($(grep 'Result "1-0"' white8 | wc -l)+$(grep 'Result "0-1"' black8 | wc -l)))
draws8=$(($(grep 'Result "1/2-1/2"' white8 | wc -l)+$(grep 'Result "1/2-1/2"' black8 | wc -l)))
losses8=$(($(grep 'Result "0-1"' white8 | wc -l)+$(grep 'Result "1-0"' black8 | wc -l)))

wins7=$(($(grep 'Result "1-0"' white7 | wc -l)+$(grep 'Result "0-1"' black7 | wc -l)))
draws7=$(($(grep 'Result "1/2-1/2"' white7 | wc -l)+$(grep 'Result "1/2-1/2"' black7 | wc -l)))
losses7=$(($(grep 'Result "0-1"' white7 | wc -l)+$(grep 'Result "1-0"' black7 | wc -l)))

echo "'7+'|$((${wins7}+${wins8}))|$((${draws8}+${draws7}))|$((${losses8}+${losses7}))" >> ../data/qv2r_by_pawns.csv

rm all_qv2r.pgn tmp8 tmp7 white8 white7 black8 black7 ret8

for i in 6 5 4 3 2
do
    j=$((i+1))
    pgn-extract -s -z tags/qv2r${i}p -otmp${i} -nret${i} ret${j}
    pgn-extract -s -y tags/qv2r${i}p -owhite${i} -nblack${i} tmp${i}

    wins=$(($(grep 'Result "1-0"' white${i} | wc -l)+$(grep 'Result "0-1"' black${i} | wc -l)))
    draws=$(($(grep 'Result "1/2-1/2"' white${i} | wc -l)+$(grep 'Result "1/2-1/2"' black${i} | wc -l)))
    losses=$(($(grep 'Result "0-1"' white${i} | wc -l)+$(grep 'Result "1-0"' black${i} | wc -l)))

    echo "'${i}'|${wins}|${draws}|${losses}" >> ../data/qv2r_by_pawns.csv

    rm tmp${i} white${i} black${i} ret${j}
done

pgn-extract -s -z tags/qv2r1p -otmp1 -nret1 ret2
pgn-extract -s -y tags/qv2r1p -owhite1 -nblack1 tmp1

wins1=$(($(grep 'Result "1-0"' white1 | wc -l)+$(grep 'Result "0-1"' black1 | wc -l)))
draws1=$(($(grep 'Result "1/2-1/2"' white1 | wc -l)+$(grep 'Result "1/2-1/2"' black1 | wc -l)))
losses1=$(($(grep 'Result "0-1"' white1 | wc -l)+$(grep 'Result "1-0"' black1 | wc -l)))

rm tmp1 white1 black1 ret2

pgn-extract -s -y tags/qv2r -owhite0 -nblack0 ret1

wins0=$(($(grep 'Result "1-0"' white0 | wc -l)+$(grep 'Result "0-1"' black0 | wc -l)))
draws0=$(($(grep 'Result "1/2-1/2"' white0 | wc -l)+$(grep 'Result "1/2-1/2"' black0 | wc -l)))
losses0=$(($(grep 'Result "0-1"' white0 | wc -l)+$(grep 'Result "1-0"' black0 | wc -l)))

echo "'1-'|$((${wins1}+${wins0}))|$((${draws1}+${draws0}))|$((${losses1}+${losses0}))" >> ../data/qv2r_by_pawns.csv

rm white0 black0 ret1