teams = [
  ["阪神タイガース", "阪神"],
  ["横浜DeNAベイスターズ", "DeNA"],
  ["読売ジャイアンツ", "巨人"],
  ["中日ドラゴンズ", "中日"],
  ["広島東洋カープ", "広島"],
  ["東京ヤクルトスワローズ", "ヤクルト"],
  ["福岡ソフトバンクホークス", "ソフトバンク"],
  ["北海道日本ハムファイターズ", "日本ハム"],
  ["オリックス・バファローズ", "オリックス"],
  ["東北楽天ゴールデンイーグルス", "楽天"],
  ["埼玉西武ライオンズ", "西武"],
  ["千葉ロッテマリーンズ", "ロッテ"],
]

teams.each do |name, short_name|
  Team.find_or_create_by!(name: name) do |t|
    t.short_name = short_name
  end
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
  { name: "ZOZOマリンスタジアム", short_name: "ZOZO" }
]

stadiums.each do |attrs|
  Stadium.find_or_create_by!(name: attrs[:name]) do |s|
    s.short_name = attrs[:short_name]
  end
end
