class Workpackage < ActiveRecord::Base
  belongs_to :subtask
  belongs_to :workpackage
  has_many :questions
  has_many :predecessors, class_name: 'workpackage'
  has_one :allocationitem
  validates :name, presence: true
end
