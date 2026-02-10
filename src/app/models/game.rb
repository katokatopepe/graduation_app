class Game < ApplicationRecord
  belongs_to :user
  belongs_to :stadium
  belongs_to :opponent_team, class_name: "Team"

  has_many_attached :photos

  enum :home_away, { home: 0, away: 1 }, prefix: true
  enum :result, { win: 0, lose: 1, draw: 2, canceled: 3 }, prefix: true

  validates :date, presence: true
  validates :home_away, presence: true
  validates :favorite_team_score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :opponent_score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :opponent_team, presence: true
  validates :stadium, presence: true

  validate :custom_stadium_name_required_when_other

  before_validation :clear_custom_stadium_name_unless_other
  before_validation :set_result_from_score

  private

  def other_stadium?
    stadium&.name == "その他"
  end

  def set_result_from_score
    return if result_canceled?
    return if favorite_team_score.nil? || opponent_score.nil?

    if favorite_team_score > opponent_score
      self.result = :win
    elsif favorite_team_score < opponent_score
      self.result = :lose
    else
      self.result = :draw
    end
  end

  def custom_stadium_name_required_when_other
    return unless other_stadium?
    errors.add(:custom_stadium_name, "を入力してください（球場で「その他」を選択した場合）") if custom_stadium_name.blank?
  end

  def clear_custom_stadium_name_unless_other
    self.custom_stadium_name = nil unless other_stadium?
  end
end
