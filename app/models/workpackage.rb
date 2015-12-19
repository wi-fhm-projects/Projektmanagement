class Workpackage < ActiveRecord::Base
  belongs_to :subtask
  validates :name, presence: true
end
