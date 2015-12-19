class Project < ActiveRecord::Base
  has_many :subproducts, dependent: :destroy
  has_many :kinds, dependent: :destroy
  has_many :tasks, dependent: :destroy
  validates :title, presence: true
end
