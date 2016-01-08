class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :pessimistic_average
      t.integer :realistic_average
      t.integer :optimistic_average
      t.references :questionary, index: true
      t.references :workpackage, index: true
      t.timestamps null: false
    end
  end
end
