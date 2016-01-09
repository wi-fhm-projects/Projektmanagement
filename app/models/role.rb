class Role < ActiveRecord::Base
  belongs_to :kind
  has_one :allocationitem
  has_many :requirments, dependent: :destroy
  validates :name, presence: true
end
