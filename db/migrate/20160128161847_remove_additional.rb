class RemoveAdditional < ActiveRecord::Migration
  def change
	remove_column :reports, :additional
  end
end
