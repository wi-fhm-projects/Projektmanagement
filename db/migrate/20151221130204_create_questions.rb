class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :frage
      t.integer :response_average
      t.references :questionary, index: true
      t.references :workpackage, index: true
      t.timestamps null: false
    end
  end
end
