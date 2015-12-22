class Questionary < ActiveRecord::Base
  belongs_to :project
  has_many :questions
end
