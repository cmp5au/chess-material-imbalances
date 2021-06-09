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

urls=${urls:1}

echo $urls