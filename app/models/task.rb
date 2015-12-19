class Task < ActiveRecord::Base
  has_many :subtasks, dependent: :destroy
  belongs_to :project
  validates :name, presence: true
end
