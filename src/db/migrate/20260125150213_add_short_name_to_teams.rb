class AddShortNameToTeams < ActiveRecord::Migration[8.1]
  def change
    add_column :teams, :short_name, :string
  end
end
