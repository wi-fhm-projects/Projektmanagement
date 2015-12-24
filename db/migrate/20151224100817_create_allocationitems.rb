class CreateAllocationitems < ActiveRecord::Migration
  def change
    create_table :allocationitems do |t|
      t.references :workpackage, index: true
      t.references :component, index: true
      t.references :role, index: true
      t.timestamps null: false
    end
  end
end
