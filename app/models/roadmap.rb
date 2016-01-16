class Roadmap < ActiveRecord::Base
  belongs_to :project
  belongs_to :questionary

  validates :start, presence: true
end
