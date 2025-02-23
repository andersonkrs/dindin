module Components::ComboboxHelper
  def combobox_tag(form, field, collection, placeholder:, id: nil, &block)
  render partial: "shared/combobox",
    locals: {
      form: form,
      field: field,
      collection: collection,
      id: id,
      placeholder: placeholder,
      item_block: block
    }
  end
end
