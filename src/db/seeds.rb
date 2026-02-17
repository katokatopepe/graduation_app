teams = [
  # セリーグ（2025順位）
  { name: "阪神タイガース", short_name: "阪神", league: :central, last_year_rank: 1 },
  { name: "横浜DeNAベイスターズ", short_name: "DeNA", league: :central, last_year_rank: 2 },
  { name: "読売ジャイアンツ", short_name: "巨人", league: :central, last_year_rank: 3 },
  { name: "中日ドラゴンズ", short_name: "中日", league: :central, last_year_rank: 4 },
  { name: "広島東洋カープ", short_name: "広島", league: :central, last_year_rank: 5 },
  { name: "東京ヤクルトスワローズ", short_name: "ヤクルト", league: :central, last_year_rank: 6 },

  # パリーグ（2025順位）
  { name: "福岡ソフトバンクホークス", short_name: "ソフトバンク", league: :pacific, last_year_rank: 1 },
  { name: "北海道日本ハムファイターズ", short_name: "日本ハム", league: :pacific, last_year_rank: 2 },
  { name: "オリックス・バファローズ", short_name: "オリックス", league: :pacific, last_year_rank: 3 },
  { name: "東北楽天ゴールデンイーグルス", short_name: "楽天", league: :pacific, last_year_rank: 4 },
  { name: "埼玉西武ライオンズ", short_name: "西武", league: :pacific, last_year_rank: 5 },
  { name: "千葉ロッテマリーンズ", short_name: "ロッテ", league: :pacific, last_year_rank: 6 },
]

teams.each do |attrs|
  Team.find_or_initialize_by(name: attrs[:name]).update!(attrs)
end


stadiums = [
  { name: "阪神甲子園球場", short_name: "甲子園" },
  { name: "横浜スタジアム", short_name: "ハマスタ" },
  { name: "東京ドーム", short_name: "東京D" },
  { name: "バンテリンドーム ナゴヤ", short_name: "バンテリンD" },
  { name: "MAZDA Zoom-Zoom スタジアム広島", short_name: "マツダ" },
  { name: "明治神宮野球場", short_name: "神宮" },
  { name: "みずほPayPayドーム福岡", short_name: "PayPay" },
  { name: "エスコンフィールドHOKKAIDO", short_name: "エスコン" },
  { name: "京セラドーム大阪", short_name: "京セラ" },
  { name: "楽天モバイルパーク宮城", short_name: "楽天" },
  { name: "ベルーナドーム", short_name: "ベルーナ" },
  { name: "ZOZOマリンスタジアム", short_name: "ZOZO" },
  { name: "その他", short_name: "その他" }
]

stadiums.each do |attrs|
  Stadium.find_or_create_by!(name: attrs[:name]) do |s|
    s.short_name = attrs[:short_name]
  end
end
