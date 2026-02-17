class AddLeagueAndLastYearRankToTeams < ActiveRecord::Migration[8.1]
  def change
  add_column :teams, :league, :integer, null: false, default: 0
  add_column :teams, :last_year_rank, :integer, null: false, default: 0
  end
end
