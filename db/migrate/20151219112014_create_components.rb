class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name
      t.string :description
      t.references :modul, index: true
      t.references :allocationItem, index: true
      t.timestamps null: false
    end
  end
end
