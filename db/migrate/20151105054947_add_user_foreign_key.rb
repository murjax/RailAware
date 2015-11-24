class AddUserForeignKey < ActiveRecord::Migration
  def change
	change_table :reports do |t|
		t.string "user_id"
	end
  end
end
