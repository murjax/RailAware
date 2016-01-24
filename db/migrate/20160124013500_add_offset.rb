class AddOffset < ActiveRecord::Migration
  def change
	add_column :reports, :offset, :string
  end
end
