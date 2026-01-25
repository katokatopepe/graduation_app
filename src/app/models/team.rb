class Team < ApplicationRecord
  has_many :users, foreign_key: :favorite_team_id, dependent: :restrict_with_error
end
