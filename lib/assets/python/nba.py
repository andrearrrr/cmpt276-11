# import nba_py
# from nba_py import player
# from nba_py import game
#
# plist = nba_py.player.PlayerList(league_id='00', season='2017-18', only_current=1)
#
# # get Data Frame with all the NBA players
# p_df = plist.info()
#
# # array of players as dictionaries
# p_dict = p_df.T.to_dict().values()
# '''
# {u'GAMES_PLAYED_FLAG': u'Y', u'DISPLAY_FIRST_LAST': u'Alex Abrines', u'TEAM_ABBREVIATION': u'OKC', u'TEAM_ID': 1610612760, u'TO_YEAR': u'2017', u'FROM_YEAR': u'2016', u'PLAYERCODE': u'alex_abrines', u'PERSON_ID': 203518, u'DISPLAY_LAST_COMMA_FIRST': u'Abrines, Alex', u'ROSTERSTATUS': 1, u'TEAM_CODE': u'thunder', u'TEAM_NAME': u'Thunder', u'TEAM_CITY': u'Oklahoma City'}
# '''
# for p in p_dict[4:5]:
#     print p['PLAYERCODE']
#     p_id = p['PERSON_ID']
#     print player.PlayerCareer(p_id, per_mode='PerGame', league_id='00').regular_season_totals()
#     print player.PlayerGameLogs(p_id, league_id='00', season='2017-18', season_type='Regular Season').info()

import nba_py
from nba_py import player
from nba_py import game
#
plist = nba_py.player.PlayerList(league_id='00', season='2017-18', only_current=1)
p_df = plist.info()
p_dict = p_df.T.to_dict().values()
p = p_dict[10]
p_id = p['PERSON_ID']
#print 'testing'

game_log = player.PlayerGameLogs(p_id, league_id='00', season='2017-18', season_type='Regular Season').info()
colnames = list(game_log.columns.values)
print game_log.to_json(orient='records')
