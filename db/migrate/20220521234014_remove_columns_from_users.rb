class RemoveColumnsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :total_games
    remove_column :users, :total_wins
    remove_column :users, :fascist_games
    remove_column :users, :fascist_wins
    remove_column :users, :liberal_games
    remove_column :users, :liberal_wins
    remove_column :users, :hitler_games
    remove_column :users, :hitler_wins
    remove_column :users, :liberal_wr
    remove_column :users, :fascist_wr
    remove_column :users, :hitler_wr
  end
end
