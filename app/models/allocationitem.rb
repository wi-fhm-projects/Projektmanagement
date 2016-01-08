class Allocationitem < ActiveRecord::Base
  belongs_to :workpackage
  belongs_to :component
  belongs_to :role
end
