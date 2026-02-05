class CreateStadiums < ActiveRecord::Migration[8.1]
  def change
    create_table :stadiums do |t|
      t.string :name, null: false
      t.string :short_name, null: false

      t.timestamps
    end
    add_index :stadiums, :name, unique: true
    add_index :stadiums, :short_name, unique: true
  end
end
