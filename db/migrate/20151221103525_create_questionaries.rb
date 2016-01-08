class CreateQuestionaries < ActiveRecord::Migration
  def change
    create_table :questionaries do |t|
      t.integer :runde
      t.references :project, index: true
      t.timestamps null: false
    end
  end
end
