class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  http_basic_authenticate_with(
    name: Rails.application.config_for(:admin).username,
    password: Rails.application.config_for(:admin).password,
  )
end
