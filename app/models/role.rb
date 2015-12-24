class Role < ActiveRecord::Base
  belongs_to :kind
  belongs_to :allocationItem
  has_many :requirments
  validates :name, presence: true
end
