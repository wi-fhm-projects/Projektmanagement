class Subtask < ActiveRecord::Base
  belongs_to :task
  has_many :workpackages, dependent: :destroy
  validates :name, presence: true
end
