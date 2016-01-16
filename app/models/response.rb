class Response < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :realistic, :optimistic, :pessimistic, presence: true, numericality: { only_integer: true }
end
