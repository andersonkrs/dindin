module UsersHelper
  COLORS_AVATAR_PLACEHOLDER = [
    "bg-(--color-avatar-placeholder-1)",
    "bg-(--color-avatar-placeholder-2)",
    "bg-(--color-avatar-placeholder-3)",
    "bg-(--color-avatar-placeholder-4)",
    "bg-(--color-avatar-placeholder-5)"
  ].freeze

  def title_initials(user)
    words = user.name.upcase.split(" ")

    if words.length > 1
      words.values_at(0, -1).map { _1.chars.first }.join()
    else
      words.first.chars.first
    end
  end

  def avatar_color(user)
    return if user.avatar.attached?

    color_index = user.id % COLORS_AVATAR_PLACEHOLDER.size

    COLORS_AVATAR_PLACEHOLDER[color_index]
  end
end
