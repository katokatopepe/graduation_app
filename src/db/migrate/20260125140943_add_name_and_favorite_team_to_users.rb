class AddNameAndFavoriteTeamToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :name, :string, null: false
    add_reference :users, :favorite_team, null: false,foreign_key: { to_table: :teams }, index: true
  end
end