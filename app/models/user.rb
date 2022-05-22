# frozen_string_literal: true

class User < ApplicationRecord
  validates :steam_id, :steam_name, presence: true

  has_many :players
  has_many :games, through: :players
end
