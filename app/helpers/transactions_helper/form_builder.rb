module TransactionsHelper
  class FormBuilder < ActionView::Helpers::FormBuilder
    def category_icon_combobox(field, placeholder:, collection:)
      @template.render(
        partial: "transactions/category_combobox",
        locals: {
          field: field,
          placeholder: placeholder,
          form: self,
          collection: collection
        }
      )
    end
  end
end
