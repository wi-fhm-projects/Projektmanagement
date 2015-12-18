class Project < ActiveRecord::Base
  has_many :subproducts
  has_many :kinds
  has_many :tasks
end
