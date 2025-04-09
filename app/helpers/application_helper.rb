module ApplicationHelper
  def icon(name, **options)
    raw SvgIcon.render(name, **options)
  end

  def title_initials(title)
    title.upcase.split(" ").values_at(0, -1).map { _1.chars.first }.join()
  end
end
