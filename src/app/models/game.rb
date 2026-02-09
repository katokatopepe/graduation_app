class Game < ApplicationRecord
  belongs_to :user
  belongs_to :stadium, optional: true
  belongs_to :opponent_team, class_name: "Team"

  enum :home_away, { home: 0, away: 1 }, prefix: true
  enum :result, { win: 0, lose: 1, draw: 2, canceled: 3 }, prefix: true

  before_validation :set_result_from_score

  private

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
end
