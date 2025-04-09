class User < ApplicationRecord
  normalizes :email, with: ->(e) { e.strip.downcase }

  has_secure_password :password, validations: true

  has_one_attached :avatar, service: :local

  validates :password, presence: true, length: { minimum: 5, maximum: 72 }, on: [:onboarding, :password_reset]
  validates_confirmation_of :password, allow_blank: false, on: [:password_reset]

  has_many :sessions, dependent: :destroy
  has_many :transactions, dependent: :destroy, foreign_key: :creator_id
end
