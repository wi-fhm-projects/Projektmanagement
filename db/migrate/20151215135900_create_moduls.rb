class CreateModuls < ActiveRecord::Migration
  def change
    create_table :moduls do |t|
      t.string :name
      t.string :description
      t.references :subproduct, index: true
      t.timestamps null: false
    end
  end
end
