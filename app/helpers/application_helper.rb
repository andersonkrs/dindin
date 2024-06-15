module ApplicationHelper
  def icon(name, **options)
    raw SvgIcon.render(name, **options)
  end
end
