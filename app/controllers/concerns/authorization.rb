module Authorization
  extend ActiveSupport::Concern

  private

  def ensure_can_administer
    unless Current.user.can_administer?
      flash[:alert] = "Only administrators can perform this action"
      redirect_back(fallback_location: root_path(format: :html))
    end
  end

  def ensure_current_user
    head :forbidden unless @user.current?
  end
end
