class Current < ActiveSupport::CurrentAttributes
  attribute :request_id
  attribute :session

  delegate :user, to: :session, allow_nil: true
  delegate :user_agent, to: :session, allow_nil: true
  delegate :ip_address, to: :session, allow_nil: true

  def account
    AppAccount.default
  end
end
