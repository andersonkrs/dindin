class ApplicationController < ActionController::Base
  include Authentication
  include Authorization
  include SetCurrentRequestDetails
  include I18n::Gettext::Helpers

  etag { Current.session&.id }

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :_
end
