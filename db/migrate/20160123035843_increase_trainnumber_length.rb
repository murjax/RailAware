class IncreaseTrainnumberLength < ActiveRecord::Migration
  def change
	change_column :reports, :trainnumber, :string, :limit => 255
  end
end
