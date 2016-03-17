class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    product = Product.find_by(id: params[:id])
    render json: product, status: 200
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  def show_id
  end

  def show_name
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

      if @product.save
        render json: product, status: 201
      else
        render json: product.errors, status: 422
      end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
      if @product.update(product_params)
        render json: @product, status: 200
      else
        render json: @product.errors, status: :unprocessable_entit
      end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    render json: @product , status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :status, :id_user)
    end
end
