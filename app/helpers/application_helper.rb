module ApplicationHelper
  def icon(name, **options)
    raw SvgIcon.render(name, **options)
  end

  def title_initials(title)
    words = title.upcase.split(" ")

    if words.length > 1
      words.values_at(0, -1).map { _1.chars.first }.join()
    else
      words.first.chars.first
    end
  end
end
