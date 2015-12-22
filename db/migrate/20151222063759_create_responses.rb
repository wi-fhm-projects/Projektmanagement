class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :antwort
      t.references :question, index: true
      t.timestamps null: false
    end
  end
end
