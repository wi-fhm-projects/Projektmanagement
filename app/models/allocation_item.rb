class AllocationItem < ActiveRecord::Base
  belongs_to :workpackage
  has_one :component
  has_one :role
end
