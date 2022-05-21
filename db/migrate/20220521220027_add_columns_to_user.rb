class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :liberal_wins, :integer, default: 0
    add_column :users, :fascist_wins, :integer, default: 0
    add_column :users, :hitler_wins, :integer, default: 0
    add_column :users, :liberal_wr, :float, default: 0.0
    add_column :users, :fascist_wr, :float, default: 0.0
    add_column :users, :hitler_wr, :float, default: 0.0
    add_column :users, :gamble_successes, :integer, default: 0
    add_column :users, :gamble_attempts, :integer, default: 0
  end
end
