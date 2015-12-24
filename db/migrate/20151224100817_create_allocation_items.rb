class CreateAllocationItems < ActiveRecord::Migration
  def change
    create_table :allocation_items do |t|
      t.references :workpackage, index: true
      t.timestamps null: false
    end
  end
end
