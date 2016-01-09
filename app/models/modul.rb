class Modul < ActiveRecord::Base
  belongs_to :subproduct
  has_many :components, dependent: :destroy
  validates :name, presence: true
end
