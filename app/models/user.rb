class User < ApplicationRecord
  has_many :user_parties
  has_many :users, through: :user_parties

  validates_presence_of :name, :email
  validates :email, uniqueness: true
end
