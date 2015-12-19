class Kind < ActiveRecord::Base
  has_many :roles, dependent: :destroy
  belongs_to :project
end
