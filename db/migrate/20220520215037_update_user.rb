# frozen_string_literal: true

class UpdateUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :steam_id, :string
    add_index :users, :steam_id, unique: true
    add_column :users, :steam_name, :string
    add_index :users, :steam_name
  end
end
