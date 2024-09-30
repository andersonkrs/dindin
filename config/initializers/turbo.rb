ActiveSupport.on_load :turbo_streams_tag_builder do
  def flash
    action :replace, :flash, partial: "shared/notifications"
  end
end
