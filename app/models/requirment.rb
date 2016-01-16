class Requirment < ActiveRecord::Base
  belongs_to :role

  validates :qualifikation, :experience, presence: true
end
