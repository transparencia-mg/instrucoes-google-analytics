class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # :registerable, :recoverable -- para não deixar usuário se cadastrar ou recuperar senha
  devise :database_authenticatable, :rememberable, :validatable
  validates :email, presence: true
  validates :email, uniqueness: true

end