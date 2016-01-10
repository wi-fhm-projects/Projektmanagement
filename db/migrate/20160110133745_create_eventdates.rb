class CreateEventdates < ActiveRecord::Migration
  def change
    create_table :eventdates do |t|
      t.references :workpackage, index: true
      t.date :startDate
      t.date :endDate

      t.timestamps null: false
    end
  end
end
