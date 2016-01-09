class Userquest < ActiveRecord::Base
  belongs_to :user
  belongs_to :questionary
end
