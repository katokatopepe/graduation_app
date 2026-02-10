class User < ApplicationRecord
  authenticates_with_sorcery!
  attr_accessor :password_confirmation
  validates :password, confirmation: true

  belongs_to :favorite_team, class_name: "Team"

  has_many :games, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
