class Player < ApplicationRecord
  validates :role, presence: true
  validates :role, inclusion: { in: %w(liberal fascist hitler) }

  belongs_to :user
end
