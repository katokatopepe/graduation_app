class Team < ApplicationRecord
  has_many :users, foreign_key: :favorite_team_id, dependent: :restrict_with_error
  validates :name, presence: true, uniqueness: true
  validates :short_name, presence: true, uniqueness: true
  ORDER_BY_LAST_SEASON = [
    # セ・リーグ（昨年度順位順）
    "阪神タイガース",
    "横浜DeNAベイスターズ",
    "読売ジャイアンツ",
    "中日ドラゴンズ",
    "広島東洋カープ",
    "東京ヤクルトスワローズ",

    # パ・リーグ（昨年度順位順）
    "福岡ソフトバンクホークス",
    "北海道日本ハムファイターズ",
    "オリックス・バファローズ",
    "東北楽天ゴールデンイーグルス",
    "埼玉西武ライオンズ",
    "千葉ロッテマリーンズ"
  ].freeze

  def display_name(style = :full)
    style.to_sym == :short ? short_name : name
  end
end
