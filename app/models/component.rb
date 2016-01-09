class Component < ActiveRecord::Base
  belongs_to :modul
  has_one :allocationitem, dependent: :destroy
  validates :name, presence: true
end
