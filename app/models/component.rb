class Component < ActiveRecord::Base
  belongs_to :modul
  validates :name, presence: true
end
