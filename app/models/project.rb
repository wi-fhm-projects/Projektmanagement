class Project < ActiveRecord::Base
  has_many :subproducts, dependent: :destroy
  has_many :kinds, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :questionarys, dependent: :destroy
  has_many :roadmaps, dependent: :destroy
  validates :title, presence: true
end
