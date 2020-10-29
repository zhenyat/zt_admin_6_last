class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update,:destroy]

  def index
    @products = policy_scope(Product)
  end

  def show
    authorize @product
  end

  def new
    @product = Product.new
    authorize @product
  end

  def edit
    authorize @product
  end

  def create
    @product = Product.new(product_params)
    authorize @product
    if @product.save
      flash[:success] = t('messages.created', model: @product.class.model_name.human)
      redirect_to [:admin, @product]
    else      
      render :new
    end
  end

  def update
    authorize @product
    if @product.update(product_params)
      flash[:success] = t('messages.updated', model: @product.class.model_name.human)
      redirect_to [:admin, @product]
    else      
      render :edit
    end
  end

  def destroy
    authorize @product
    @product.destroy
    flash[:success] = t('messages.deleted', model: @product.class.model_name.human)
    redirect_to admin_products_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def product_params
      params.require(:product).permit(:name, :title, :sku, :price, :description, :status)
    end
end
