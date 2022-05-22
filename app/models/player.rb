# frozen_string_literal: true

class Player < ApplicationRecord
  validates :role, :user, :game, presence: true
  validates :win, inclusion: { in: [ true, false ] }
  validates :role, inclusion: { in: %w[liberal fascist hitler] }

  belongs_to :user
  belongs_to :game
end
