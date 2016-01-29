class CombineLocomotiveColumns < ActiveRecord::Migration
  def change
	remove_column :reports, :loconumber
	remove_column :reports, :locotype
	remove_column :reports, :railroad
	add_column :reports, :locomotives, :string
  end
end
