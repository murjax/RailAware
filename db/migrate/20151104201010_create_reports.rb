class CreateReports < ActiveRecord::Migration
  def up
    create_table :reports do |t|
	  t.string "username", :limit => 50
	  t.string "trainnumber", :limit => 10
	  t.string "loconumber", :limit => 10
	  t.string "locotype", :limit => 20
	  t.string "railroad", :limit => 50
	  t.string "location", :limit => 30
	  t.string "direction", :limit => 10
	  t.string "additional"
	  t.string "info"
	  t.float "latitude"
	  t.float "longitude"
	  t.datetime "time"
      t.timestamps
    end
  end
  
  def down
	drop_table :reports
  end
end
