class AddConstraintsToTeams < ActiveRecord::Migration[8.1]
  def change
    change_column_null :teams, :name, false
    change_column_null :teams, :short_name, false

    add_index :teams, :name, unique: true
    add_index :teams, :short_name, unique: true
  end
end
