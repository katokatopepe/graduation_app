class CreateGames < ActiveRecord::Migration[8.1]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.references :opponent_team, null: false, foreign_key: { to_table: :teams }
      t.references :stadium, null: true, foreign_key: true
      t.date :date, null: false
      t.integer :home_away, null: false
      t.string :starting_pitcher
      t.integer :favorite_team_score
      t.integer :opponent_score
      t.string :custom_stadium_name
      t.integer :result
      t.string :video_url

      t.timestamps
    end
    add_index :games, [:user_id, :date]
  end
end
