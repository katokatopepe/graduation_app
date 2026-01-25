class User < ApplicationRecord
  authenticates_with_sorcery!
  belongs_to :favorite_team, class_name: "Team"

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
