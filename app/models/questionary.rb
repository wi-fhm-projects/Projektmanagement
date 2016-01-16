class Questionary < ActiveRecord::Base
  belongs_to :project
  has_many :questions, dependent: :destroy
  has_many :userquests, dependent: :destroy
  has_many :users, through: :userquests
  has_one :roadmap, dependent: :destroy
end
