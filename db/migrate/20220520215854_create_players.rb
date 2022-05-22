# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players, &:timestamps
  end
end
