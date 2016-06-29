class AddRailroadToReports < ActiveRecord::Migration
  def change
  	add_column :reports, :railroad, :string
  end
end
