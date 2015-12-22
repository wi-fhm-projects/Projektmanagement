class Workpackage < ActiveRecord::Base
  belongs_to :subtask
  has_many :questions
  validates :name, presence: true
end
