class CategoriesController < AdminController
  before_action :set_category, only: %i[ show edit update destroy ]
  before_action :set_top_level_categories, only: %i[ new edit ]

  # GET /categories or /categories.json
  def index
    @categories = Category.top_level.includes(:sub_category).order(:name)
  end

  # GET /categories/1 or /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = current_user.categories.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories or /categories.json
  def create
    @category = current_user.categories.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: "Category was successfully created." }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1 or /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: "Category was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 or /categories/1.json
  def destroy
    @category.destroy!

    respond_to do |format|
      format.html { redirect_to categories_path, notice: "Category was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    def set_top_level_categories
      if action_name == "edit"
        @top_level_categories = Category.top_level.where.not(id: params[:id])
      else
        @top_level_categories = Category.top_level
      end
    end

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name, :super_category_id)
    end
end
