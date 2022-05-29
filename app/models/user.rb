# frozen_string_literal: true

class User < ApplicationRecord
  searchkick word_middle: [:steam_name]

  validates :steam_id, :steam_name, presence: true

  has_many :players
  has_many :games, through: :players
  has_many :submitted_games, class_name: 'Game', foreign_key: 'submitter_id'

  def total_wr
    players = self.players.joins(:game).where(@@game_params)
    return 0 if players.count.zero?

    [players.where(win: true).count / players.count.to_f, -1 * players.count]
  end

  def lib_wr
    players = self.players.joins(:game).where(@@game_params).where(role: 'liberal')
    return 0 if players.count.zero?

    [players.where(win: true).count / players.count.to_f, -1 * players.count]
  end

  def fas_wr
    players = self.players.joins(:game).where(@@game_params).where(role: %w[fascist hitler])
    return 0 if players.count.zero?

    [players.where(win: true).count / players.count.to_f, -1 * players.count]
  end

  def self.sorted_by_total_wr(game_params)
    @@game_params = game_params
    User.all.sort_by(&:total_wr).reverse!
  end

  def self.sorted_by_lib_wr(game_params)
    @@game_params = game_params
    User.all.sort_by(&:lib_wr).reverse!
  end

  def self.sorted_by_fas_wr(game_params)
    @@game_params = game_params
    User.all.sort_by(&:fas_wr).reverse!
  end

  def search_data
    { steam_name: }
  end
end
