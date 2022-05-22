# frozen_string_literal: true

json.set! user[:steam_id] do
  json.steam_id user[:steam_id]
  json.steam_name user[:steam_name]
  json.total_games user[:total_games]
  json.total_wins user[:total_wins]
  json.liberal_games user[:liberal_games]
  json.liberal_wins user[:liberal_wins]
  json.fascist_games user[:liberal_games]
  json.fascist_wins user[:fascist_wins]
  json.hitler_games user[:hitler_games]
  json.hitler_wins user[:hitler_wins]
  json.gamble_attempts user[:gamble_attempts]
  json.gamble_successes user[:gamble_successes]
end
