class Task < ActiveRecord::Base
  has_many :subtasks
  belongs_to :project

end
