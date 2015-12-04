class AddVoteRatingColumns < ActiveRecord::Migration
  def change
	change_table :users do |t|
		t.string "rating"
		t.string "votecount"
	end
  end
end
