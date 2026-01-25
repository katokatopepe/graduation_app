class Team < ApplicationRecord
  has_many :users, foreign_key: :favorite_team_id, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: true
  validates :short_name, presence: true, uniqueness: true

  def display_name(style = :full)
    style.to_sym == :short ? short_name : name
  end
end
