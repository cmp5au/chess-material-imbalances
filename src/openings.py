import numpy as np
import pandas as pd
from os import path
from pgn_parser import pgn, parser


if __name__ == '__main__':

    # load in and parse ~1000 game PGNs at a time,
    # retreiving the first move for White and Black
    # as well as the result. Total will be ~100k
    # games in the DataFrame

    df = pd.DataFrame({'white_move_1' : [],
                    'black_move_1' : [],
                    'score' : []})

    if not path.exists('../data/csv/100k_opening_moves.csv'):
        with open('../data/pgn/2013-2014-blitz.pgn', mode='r') as raw_pgn:
            for i in range(100):
                move_list = raw_pgn.read(10 ** 6).split('\n\n')
                if move_list[1][:2] == '1.':
                    move_list = move_list[1::2]
                else:
                    move_list = move_list[2::2]
                games = [parser.parse(moves, actions=pgn.Actions())
                        for moves in move_list[:-1]]
                for game in games:
                    df = df.append({'white_move_1': game.move(1).white.san,
                                    'black_move_1': game.move(1).black.san,
                                    'score': str(game.score)}, ignore_index=True
                    )

        # create additional columns for numerical scoring for White and Black
        df['white_score'] = df['score'].transform(lambda x: 1 if x == '1-0' else 0 if x == '0-1' else 0.5)
        df['black_score'] = 1 - df['white_score']

        df.to_csv('../data/csv/100k_opening_moves.csv', sep='|')

    else:
        df = pd.read_csv('../data/csv/100k_opening_moves.csv', sep='|')


    grouped_moves = df.groupby(['white_move_1', 'black_move_1']).agg(
        num_games=('white_move_1', 'count'),
        avg_white_score=('white_score', np.mean),
        avg_black_score=('black_score', np.mean)
        ).sort_values('num_games', ascending=False)

    common_grouped_moves = grouped_moves[grouped_moves['num_games'] > 100]
    # drop games where Black didn't respond with a move on move 1
    common_grouped_moves = common_grouped_moves.drop(index=[('e4',''), ('d4','')])
    common_grouped_moves = common_grouped_moves.sort_values('avg_white_score')

    white_grouped_moves = df.groupby('white_move_1').agg(
        num_games=('white_move_1', 'count'),
        avg_white_score=('white_score', np.mean),
        avg_black_score=('black_score', np.mean)
        ).sort_values('num_games', ascending=False)


    white_common_grouped_moves = white_grouped_moves[white_grouped_moves['num_games'] > 100]
    white_common_grouped_moves = white_common_grouped_moves.sort_values('avg_white_score')

    print(common_grouped_moves)