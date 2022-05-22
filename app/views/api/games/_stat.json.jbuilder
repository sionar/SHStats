# frozen_string_literal: true

json.set! stat[:num_players] do
  json.num_players stat[:num_players]
  json.total_games stat[:total_games]
  json.liberal_wins stat[:liberal_wins]
  json.liberal_wins_policy stat[:liberal_wins_policy]
  json.fascist_wins_policy stat[:fascist_wins_policy]
end
