class RenameTypeToLocoType < ActiveRecord::Migration
  def change
  	rename_column :locomotives, :type, :loco_type
  end
end
