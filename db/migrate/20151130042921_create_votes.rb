class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
		t.string "username", :limit => 50
		t.string "report_id"
		t.timestamps
    end
  end
end
