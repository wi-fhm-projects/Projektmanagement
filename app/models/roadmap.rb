class Roadmap < ActiveRecord::Base
  belongs_to :project
  belongs_to :questionary
end
