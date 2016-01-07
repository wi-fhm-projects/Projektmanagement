class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :startDate
      t.references :questionarys
      t.references :project, index: true

      t.timestamps null: false
    end
  end
end
