class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.string :location
      t.integer :spot_id, unique: true
      t.st_point :location_coords, geographic: true

      t.timestamps
    end
    add_index :spots, :spot_id
    add_index :spots, :location
  end
end
