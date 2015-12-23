class Role < ActiveRecord::Base
  belongs_to :kind
  has_many :requirments
  validates :name, presence: true
end
