class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :frage
      t.references :questionary, index: true
      t.timestamps null: false
    end
  end
end
