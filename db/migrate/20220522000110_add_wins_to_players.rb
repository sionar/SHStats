# frozen_string_literal: true

class AddWinsToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :win, :boolean
  end
end
