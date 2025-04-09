class OnboardingsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  before_action :prevent_running_after_setup, only: %i[ new ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save(context: :onboarding)
      Onboarding.run!

      start_new_session_for @user
      redirect_to root_url(format: :html)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def prevent_running_after_setup
    redirect_to root_url(format: :html) if User.any?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
