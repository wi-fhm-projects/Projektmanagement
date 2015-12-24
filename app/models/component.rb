class Component < ActiveRecord::Base
  belongs_to :modul
  has_one :allocationitem
  validates :name, presence: true
end
