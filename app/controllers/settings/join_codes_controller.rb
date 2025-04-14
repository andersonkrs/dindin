class Settings::JoinCodesController < ApplicationController
  before_action :ensure_can_administer

  def create
    Current.account.reset_join_code

    redirect_to users_url, status: :see_other
  end
end
