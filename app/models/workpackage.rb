class Workpackage < ActiveRecord::Base
  belongs_to :subtask
  has_many :questions
  has_many :workpackage
  has_one :allocationitem
  validates :name, presence: true
end
