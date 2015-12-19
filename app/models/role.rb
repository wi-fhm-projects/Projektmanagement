class Role < ActiveRecord::Base
  belongs_to :kind
  validates :name, presence: true
end
