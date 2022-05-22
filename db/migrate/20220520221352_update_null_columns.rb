# frozen_string_literal: true

class UpdateNullColumns < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:users, :steam_id, false)
    change_column_null(:users, :steam_name, false)
    change_column_null(:players, :role, false)
    change_column_null(:games, :game_type, false)
    change_column_null(:games, :num_players, false)
    change_column_null(:games, :winning_team, false)
    change_column_null(:games, :win_type, false)
  end
end
