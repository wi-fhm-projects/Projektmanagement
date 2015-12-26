class CreateRequirments < ActiveRecord::Migration
  def change
    create_table :requirments do |t|
      t.string :qualifikation
      t.string :experience
      t.references :role, index: true
      t.timestamps null: false
    end
  end
end
