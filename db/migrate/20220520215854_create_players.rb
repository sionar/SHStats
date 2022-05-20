class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|

      t.timestamps
    end
  end
end
