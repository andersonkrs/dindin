class AppAccount < ApplicationRecord
  include Joinable

  DEFAULT_APP_ACCOUNT_NAME = "Dindin"

  def self.default
    first_or_create!(name: DEFAULT_APP_ACCOUNT_NAME)
  end
end
