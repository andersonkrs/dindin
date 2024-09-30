class ApplicationController < ActionController::Base
  include FastGettext::Translation

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  include SetCurrentRequestDetails

  before_action :set_gettext_locale
end
