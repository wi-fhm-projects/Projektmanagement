class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :responses, dependent: :destroy
  has_many :userquests, dependent: :destroy
  has_many :questionarys, through: :userquests

  validates_presence_of :first_name, :last_name
end
