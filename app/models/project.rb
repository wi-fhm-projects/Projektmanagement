class Project < ActiveRecord::Base
  has_many :subproducts
  has_many :kinds
end
