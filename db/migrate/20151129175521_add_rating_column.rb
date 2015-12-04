class AddRatingColumn < ActiveRecord::Migration
  def change
	change_table :reports do |t|
		t.string "rating"
	end
  end
end
