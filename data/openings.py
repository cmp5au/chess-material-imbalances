import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from pgn_parser import pgn, parser


df = pd.DataFrame({'white_move_1' : [],
                   'black_move_1' : [],
                   'score' : []})

with open('2013-2014-blitz.pgn', mode='r') as raw_pgn:
    for _ in range(100):
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

print(df.shape)