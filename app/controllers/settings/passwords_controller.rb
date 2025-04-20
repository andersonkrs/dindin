class Settings::PasswordsController < ApplicationController
  before_action :validate_current_password, only: :update

  def edit
  end

  def update
    Current.user.assign_attributes(password_params)

    if Current.user.valid?(:password_change)
      Current.user.transaction do
        Current.user.sessions.destroy_all
        Current.user.save!

        start_new_session_for(Current.user)
        redirect_to settings_path, notice: "Password updated successfully."
      end
    else
      flash.now[:alert] = "Passwords do not match. Please try again."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def validate_current_password
    return true if Current.user.authenticate(params[:user][:current_password])

    flash.now[:alert] = "Current password is incorrect. Please try again."
    render :edit, status: :unprocessable_entity
  end
end
