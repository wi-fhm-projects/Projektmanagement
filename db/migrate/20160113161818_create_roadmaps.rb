class CreateRoadmaps < ActiveRecord::Migration
  def change
    create_table :roadmaps do |t|
      t.string :title
      t.date :start
      t.references :project, index: true
      t.references :questionary, index: true
      t.timestamps null: false
    end
  end
end
