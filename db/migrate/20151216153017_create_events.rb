class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.date :startDate
      t.date :endDate

      t.timestamps null: false
    end
  end
end