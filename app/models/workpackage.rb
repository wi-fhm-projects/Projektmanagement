class Workpackage < ActiveRecord::Base
  belongs_to :subtask
  has_many :questions, dependent: :destroy
  has_one :successor, class_name:'Workpackage' # <-- Nur Dummy
  has_and_belongs_to_many :predecessors, class_name: 'Workpackage', foreign_key: 'successor_id'
  has_and_belongs_to_many :successors, class_name: 'Workpackage'
  has_one :allocationitem, dependent: :destroy
  has_one :eventdate
  validates :name, presence: true
end
