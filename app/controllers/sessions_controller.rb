class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: permitted_params[:email])

    if @user && @user.authenticate(permitted_params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:alert] = "Login failed. Please check the credentials"
      redirect_to new_session_path
    end
  end

  def destroy
    reset_session
    Current.reset
    redirect_to new_session_path
  end

  private

  def permitted_params
    params.require(:user).permit(:email, :password)
  end
end
