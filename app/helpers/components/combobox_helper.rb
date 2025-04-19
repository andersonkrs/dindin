module Components::ComboboxHelper
  def combobox_tag(form, field, collection, placeholder:, icon:, id: nil, &block)
    render partial: "shared/combobox",
      locals: {
        form: form,
        field: field,
        icon: icon,
        collection: collection,
        id: id,
        placeholder: placeholder,
        item_block: block
      }
  end

  def combobox_input_controller_actions
    %w[
      input->combobox#handleSearch
      click->combobox#toggle
      keydown.up->combobox#highlightPrevious
      keydown.down->combobox#highlightNext
      keydown.enter->combobox#chooseHighlightedItem
      focusout->combobox#clickOutside
    ].join(" ")
  end
end
