class AddTimezoneToReports < ActiveRecord::Migration
  def change
	add_column :reports, :timezone, :string
  end
end
