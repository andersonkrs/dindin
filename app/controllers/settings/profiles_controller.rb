class Settings::ProfilesController < ApplicationController
  def edit
  end

  def update
    Current.user.update!(update_params)
    redirect_to settings_path, notice: "Profile updated", status: :see_other
  end

  private

  def update_params
    params.require(:user).permit(:name)
  end
end
