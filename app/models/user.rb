class User < ApplicationRecord
  include Role, Deactivatable

  normalizes :email, with: ->(e) { e.strip.downcase }

  has_secure_password :password, validations: true

  has_one_attached :avatar, service: :local

  validates :password, presence: true, length: { minimum: 5, maximum: 72 }, on: [:onboarding, :password_change]
  validates_confirmation_of :password, allow_blank: false, on: [:password_change]

  has_many :sessions, dependent: :destroy
  has_many :transactions, dependent: :destroy, foreign_key: :creator_id

  def current?
    Current.user == self
  end
end
