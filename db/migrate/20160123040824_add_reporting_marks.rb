class AddReportingMarks < ActiveRecord::Migration
  def change
	add_column :railroads, :marks, :string
  end
end
