import numpy as np
import pandas as pd
from scipy import stats

def aggregate_results(tag):
    # aggregates White and Black results into a single
    # Pandas Series indexed by wins, draws, and losses
    
    raw_results = pd.read_csv(f'../data/csv/{tag}_results.csv', sep='|')
    return pd.Series(
        [raw_results.iloc[0, j] + raw_results.iloc[1, 2 - j] for j in range(3)],
        index=['Wins', 'Draws', 'Losses']
    )


def one_sample_proportion_test_p(tag):
    # uses the aggregate results to perform a one-sample
    # proportion test on the average points metric with null
    # hypothesis that the average point value is 0.5 and
    # two-tailed alternative hypothesis that the average point
    # value is not 0.5; returns the p-value of this test

    results = aggregate_results(tag)
    avg_points = ((results['Wins'] + 0.5 * results['Draws']) /
                    results.sum())
    se = np.sqrt(avg_points * (1 - avg_points) / results.sum())
    z = (avg_points - 0.5) / se
    if z < 0:
        return 2 * stats.norm().cdf(z)
    else:
        return 2 * (1 - stats.norm().cdf(z))


if __name__ == '__main__':
    alpha = 0.05
    tags = ['bpvnp', 'nbvrp', 'qv2r']
    for tag in tags:
        print(f'\n{tag}: statistically significant'
            # Bonferroni correction
            if one_sample_proportion_test_p(tag) < alpha / len(tags)
            else f'\n{tag}: not statistically significant',
            f'at the {100 * alpha}% significance level.')

    alpha = 0.1
    tags = [f'qv2r{i}p' for i in range(9)]
    for tag in tags:
        print(f'\n{tag}: statistically significant'
            # Bonferroni correction
            if one_sample_proportion_test_p(tag) < alpha / len(tags)
            else f'\n{tag}: not statistically significant',
            f'at the {100 * alpha}% significance level.')

    qv2r_df = pd.read_csv('../data/csv/qv2r_by_pawns.csv', delimiter="|")
    qv2r_df['win_rate'] = qv2r_df['wins'] / qv2r_df[['wins','draws','losses']].sum(axis=1)
    qv2r_df['draw_rate'] = qv2r_df['draws'] / qv2r_df[['wins','draws','losses']].sum(axis=1)
    qv2r_df['average_points'] = qv2r_df['win_rate'] + 0.5 * qv2r_df['draw_rate']

    alpha = 0.1
    rho, p = stats.spearmanr(np.arange(1, 8), qv2r_df['average_points'])

    print('\nThe rank-order of average point result vs. number of pawns remaining in a ' +
        'Queen v. 2 Rooks game is ' + ('not ' if p > alpha else '') +
        f'significant at a {100 * alpha}% significance level.\n\nThe Spearman rho ' +
        f'coefficient is {rho}\n')