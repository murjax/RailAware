class CreateRailroads < ActiveRecord::Migration
  def change
    create_table :railroads do |t|
		t.string "railroad"
		t.timestamps
    end
  end
end
