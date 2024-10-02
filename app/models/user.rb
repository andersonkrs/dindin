class User < ApplicationRecord
  has_secure_password :password, validations: true

  has_many :sessions, dependent: :destroy

  normalizes :email, with: ->(e) { e.strip.downcase }
end
