class CategoriesController < AccountController
  before_action :set_category, only: %i[ edit update ]

  def new
    @category = Category.new(kind: :expense)
  end

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: "Category created!" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: "Category updated!" }
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
    params.require(:category).permit(:title, :kind)
  end
end
