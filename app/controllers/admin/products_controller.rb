class Admin::ProductsController < ApplicationController
  # Require authentication only for edit and delete operation
  before_action :authenticate

  USER_ID = "admin"
  PASSWORD = "password"

  def index
    @products = Product.order(id: :desc).all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to [:admin, :products], notice: 'Product created!'
    else
      render :new
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy
    redirect_to [:admin, :products], notice: 'Product deleted!'
  end

  private

  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :category_id,
      :quantity,
      :image,
      :price
    )
  end

  def authenticate
     authenticate_or_request_with_http_basic do |id, password| 
        id == USER_ID && password == PASSWORD
     end
  end

end
