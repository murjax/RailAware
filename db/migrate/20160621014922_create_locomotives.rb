class CreateLocomotives < ActiveRecord::Migration
  def change
    create_table :locomotives do |t|
      t.string :railroad
      t.string :number
      t.string :type
      t.references :report, index: true

      t.timestamps null: false
    end
    add_foreign_key :locomotives, :reports
  end
end
