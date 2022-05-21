class AddGameCountsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :total_games, :integer, default: 0
    add_column :users, :total_wins, :integer, default: 0
    add_column :users, :liberal_games, :integer, default: 0
    add_column :users, :fascist_games, :integer, default: 0
    add_column :users, :hitler_games, :integer, default: 0
  end
end
