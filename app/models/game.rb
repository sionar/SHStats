# frozen_string_literal: true

class Game < ApplicationRecord
  validates :game_type, :num_players, :winning_team, :win_type, presence: true
  validates :game_type, inclusion: { in: %w[vanilla expansion] }
  validates :winning_team, inclusion: { in: %w[liberal fascist] }
  validates :win_type, inclusion: { in: %w[policy hitler] }
  validates :num_players, comparison: { greater_than_or_equal_to: 5, less_than_or_equal_to: 10 }

  has_many :players, dependent: :destroy
  has_many :users, through: :players
  belongs_to :submitter, class_name: 'User', foreign_key: 'submitter_id'

  def self.delete_games_by_submitter(submitter_id)
    submitter = User.find_by(steam_id: submitter_id)
    games = submitter.submitted_games
    games.each do |game|
      game.destroy!
    end
  end
end
