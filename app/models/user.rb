class User < ApplicationRecord

has_secure_password

validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }

validates :password, presence: true

validates :password_confirmation, presence: true

validates :first_name, presence: true

validates :last_name , presence: true

end