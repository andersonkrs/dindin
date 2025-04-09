class Settings::AvatarsController < ApplicationController
  def create
    Current.user.avatar.attach(params[:user][:avatar])
    Current.user.save!
    redirect_to edit_profile_path, notice: "Photo saved", status: :see_other
  end

  def destroy
    Current.user.avatar.purge
    redirect_to edit_profile_path, notice: "Photo removed", status: :see_other
  end
end
