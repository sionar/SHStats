class Game < ApplicationRecord
  validates :game_type, :num_players, :winning_team, :win_type, presence: true
  validates :game_type, inclusion: { in: %w(vanilla expansion) }
  validates :winning_team, inclusion: { in: %w(liberal fascist) }
  validates :win_type, inclusion: { in: %w(policy hitler) }
  validates :num_players, comparison: { greater_than_or_equal_to: 5, less_than_or_equal_to: 10 }

  has_many :players
  has_many :users, through: :players
end
