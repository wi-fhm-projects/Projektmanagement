class Component < ActiveRecord::Base
  belongs_to :modul
  belongs_to :allocationItem
  validates :name, presence: true
end
