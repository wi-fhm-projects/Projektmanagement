class Question < ActiveRecord::Base
  belongs_to :questionary
  belongs_to :workpackage
  has_many :responses
end
