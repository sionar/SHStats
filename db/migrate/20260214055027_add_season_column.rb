class AddSeasonColumn < ActiveRecord::Migration[8.1]
  def change
    add_column :games, :season, :integer, default: 1
  end
end
