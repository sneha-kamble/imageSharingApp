class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :albums
  has_many :images, through: :albums
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
