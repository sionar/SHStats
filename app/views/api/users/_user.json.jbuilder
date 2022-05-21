json.set! user.steam_id do
  json.id user.steam_id
  json.steam_name user.steam_name
  json.total_games user.total_games
  json.total_wins user.total_wins
  json.liberal_games user.liberal_games
  json.liberal_wins user.liberal_wins
  json.fascist_games user.liberal_games
  json.fascist_wins user.fascist_wins
  json.hitler_games user.hitler_games
  json.hitler_wins user.hitler_wins
  json.liberal_wr user.liberal_wr
  json.fascist_wr user.fascist_wr
  json.hitler_wr user.hitler_wr
  json.gamble_attempts user.gamble_attempts
  user.gamble_successes user.gamble_successes
end