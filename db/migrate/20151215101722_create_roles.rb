class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.references :kind, index: true
      t.references :allocationItem, index: true
      t.timestamps null: false
    end
  end
end
