class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  before_action :ensure_onboarded, only: %i[ new ]
  before_action :check_already_authenticated, only: %i[ new ]

  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { render_too_many_requests }

  def new
  end

  def create
    if user = User.authenticate_by(permitted_params)
      start_new_session_for user

      redirect_to after_authentication_url
    else
      flash[:alert] = "Try another email address or password."
      redirect_to new_session_url
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_url
  end

  private

  def permitted_params
    params.permit(:email, :password)
  end

  def ensure_onboarded
    redirect_to new_onboarding_url if User.none?
  end

  def check_already_authenticated
    resume_session
    redirect_to after_authentication_url if authenticated?
  end

  def render_too_many_requests
    flash[:alert] = "Too many requests, try again later."
    render :new, status: :too_many_requests
  end
end
