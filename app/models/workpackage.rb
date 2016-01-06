class Workpackage < ActiveRecord::Base
  belongs_to :subtask
  has_many :questions
  has_many :predecessor
  validates :name, presence: true
end
