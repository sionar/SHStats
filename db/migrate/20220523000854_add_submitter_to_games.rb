# frozen_string_literal: true

class AddSubmitterToGames < ActiveRecord::Migration[7.0]
  def change
    change_table :games do |t|
      t.belongs_to :submitter
    end
  end
end
