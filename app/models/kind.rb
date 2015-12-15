class Kind < ActiveRecord::Base
  has_many :roles
  belongs_to :project
end
