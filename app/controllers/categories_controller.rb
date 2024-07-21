class CategoriesController < AccountController
  before_action :set_category, only: %i[ edit update ]

  def new
    @active_tab = Category.kinds.fetch(params[:tab], "expense")
    @category = Category.new(kind: @active_tab)
  end

  def index
    @active_tab = Category.kinds.fetch(params[:tab], "expense")
    @categories = Category.where(kind: @active_tab).order(title: :asc)

    fresh_when @categories
  end

  def create
    @category = Category.new(category_create_params)

    respond_to do |format|
      if @category.save
        flash.now[:notice] = "Category created!"

        format.turbo_stream { render :create, status: :created }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_update_params)
        flash.now[:notice] = "Category updated!"

        format.turbo_stream { render :update, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_create_params
    params.require(:category).permit(:title, :kind, :color, :icon)
  end

  def category_update_params
    params.require(:category).permit(:title, :color, :icon)
  end
end
