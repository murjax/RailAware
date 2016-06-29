class RefineReports < ActiveRecord::Migration
  def change
  	remove_column :reports, :locomotives
  	remove_column :reports, :latitude
  	remove_column :reports, :longitude
  	remove_column :reports, :location
  	rename_column :reports, :trainnumber, :train_number
  end
end
