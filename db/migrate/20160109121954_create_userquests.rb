class CreateUserquests < ActiveRecord::Migration
  def change
    create_table :userquests do |t|
      t.boolean :newquest, default: true
      t.references :user, index: true
      t.references :questionary, index: true
      t.timestamps null: false
    end
  end
end
