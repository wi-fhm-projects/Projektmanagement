class Questionary < ActiveRecord::Base
  belongs_to :project
  has_many :questions
  has_many :userquests
  has_many :users, through: :userquests
end
