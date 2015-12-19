class Subproduct < ActiveRecord::Base
  belongs_to :project
  has_many :moduls, dependent: :destroy
end
