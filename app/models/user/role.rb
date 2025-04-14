module User::Role
  extend ActiveSupport::Concern

  included do
    enum :role, %i[ member admin ].index_with(&:to_s), default: :member
  end

  def can_administer?
    admin?
  end
end
