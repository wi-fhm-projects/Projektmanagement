class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :qualifikation
      t.string :experience
      t.references :kind, index: true
      t.timestamps null: false
    end
  end
end
