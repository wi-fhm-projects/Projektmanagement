class CreateWorkpackagesWorkpackages < ActiveRecord::Migration
  def change
    create_table :workpackages_workpackages do |t|
      t.references :workpackage
      t.references :successor
    end
  end
end
