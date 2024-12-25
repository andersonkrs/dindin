class Search::CategoriesController < AccountController
  def index
    @categories = Category
      .expense
      .where("lower(title) LIKE lower(?)", "%#{params[:q]}%")
      .order(title: :asc)
      .limit(5)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "categories_autocomplete_results",
          partial: "search/categories/autocomplete_results",
          locals: { categories: @categories }
        )
      end
    end
  end
end
