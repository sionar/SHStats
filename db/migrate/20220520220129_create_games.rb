# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string      :game_type
      t.integer     :num_players
      t.string      :winning_team
      t.string      :win_type
      t.timestamps
    end
  end
end
