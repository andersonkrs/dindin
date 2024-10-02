locale_path = Rails.root.join("config/locales")

I18n::Backend::Simple.include(I18n::Backend::Gettext)
I18n.load_path |= Dir["#{locale_path}/**/*.po"]  # Load all PO file in current directory
I18n.available_locales = [:en, :pt_BR]
I18n.default_locale = :en
