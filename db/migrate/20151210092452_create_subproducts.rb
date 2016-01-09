class CreateSubproducts < ActiveRecord::Migration
  def change
    create_table :subproducts do |t|
      t.string :name
      t.string :description
      t.references :project, index: true
      t.timestamps null: false
    end
  end
end
