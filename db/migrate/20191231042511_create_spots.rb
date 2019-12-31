class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.string :location

      t.timestamps
    end
    add_index :spots, :location
  end
end
