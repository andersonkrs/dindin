ActiveSupport.on_load :turbo_streams_tag_builder do
  def flash
    action :replace, :flash, partial: "shared/notifications"
  end

  def visit(location)
    action :visit, location
  end

  def close_dialog(target)
    action :close_dialog, target
  end
end
