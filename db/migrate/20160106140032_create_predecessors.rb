class CreatePredecessors < ActiveRecord::Migration
  def change
    create_table :predecessors do |t|

      t.timestamps null: false
    end
  end
end
