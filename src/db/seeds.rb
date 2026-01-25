teams = [
  ["読売ジャイアンツ", "巨人"],
  ["阪神タイガース", "阪神"],
  ["横浜DeNAベイスターズ", "DeNA"],
  ["広島東洋カープ", "広島"],
  ["東京ヤクルトスワローズ", "ヤクルト"],
  ["中日ドラゴンズ", "中日"],
  ["福岡ソフトバンクホークス", "ソフトバンク"],
  ["千葉ロッテマリーンズ", "ロッテ"],
  ["埼玉西武ライオンズ", "西武"],
  ["東北楽天ゴールデンイーグルス", "楽天"],
  ["北海道日本ハムファイターズ", "日本ハム"],
  ["オリックス・バファローズ", "オリックス"],
]

teams.each do |name, short_name|
  Team.find_or_create_by!(name: name) do |t|
    t.short_name = short_name
  end
end

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
