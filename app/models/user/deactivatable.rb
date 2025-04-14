module User::Deactivatable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(deactivated_at: nil) }
  end

  def deactivate
    transaction do
      sessions.delete_all
      update!(
        name: "#{name} (deactivated)",
        deactivated_at: Time.current,
        email: deactivated_email_address,
        password: SecureRandom.alphanumeric(16)
      )
    end
  end

  private

  def deactivated_email_address
    email&.gsub(/@/, "-deactivated-#{SecureRandom.uuid}@")
  end

  def can_administer?
    admin?
  end
end
