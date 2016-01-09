class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :pessimistic
      t.integer :realistic
      t.integer :optimistic
      t.references :user, index: true
      t.references :question, index: true
      t.timestamps null: false
    end
  end
end
