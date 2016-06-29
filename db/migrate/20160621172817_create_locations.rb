class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :state_prov
      t.string :latitude
      t.string :longitude
      t.references :report, index: true

      t.timestamps null: false
    end
    add_foreign_key :locations, :reports
  end
end
