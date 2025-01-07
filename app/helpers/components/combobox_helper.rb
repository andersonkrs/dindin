module Components::ComboboxHelper
  def render_combobox_item(object, &block)
    content = capture(&block)

    tag.li(
      id: "listbox-option-#{object.id}",
      class: combobox_item_classes,
      role: :option,
      data: {
        combobox_target: "item",
        action: "click->combobox#choose",
        id: object.title,
        title: object.title
      }
    ) do
      tag.div(content) +
      tag.span(
        data: { attribute: "check" },
        class: "hidden absolute inset-y-0 right-0 flex items-center pr-5 text-indigo-600 group-hover:text-white"
      ) do
        icon("check", variant: :solid, class: "size-5 stroke-6")
      end
    end
  end

  private

  def combobox_item_classes
    %w[
      group
      relative
      cursor-pointer
      py-1
      text-gray-900
      select-none
      hover:bg-indigo-600
      hover:text-white
      hover:outline-hidden
    ]
  end
end
