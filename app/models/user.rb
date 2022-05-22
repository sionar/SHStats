# frozen_string_literal: true

class User < ApplicationRecord
  validates :steam_id, :steam_name, presence: true

  has_many :players
  has_many :games, through: :players

  def total_wr
    players = self.players
    return 0 if players.count == 0

    (players.where(win: true).count / players.count)
  end

  def self.sorted_by_total_wr
    User.all.sort_by(&:total_wr)
  end
end
