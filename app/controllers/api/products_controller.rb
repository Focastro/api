module Api
  class ProductsController < ApplicationController
    before_action :set_product, only: [:edit, :update, :destroy]
    before_action :validate_session_create, only: [:create]

  # GET /products
  def index
    if Session.find_by(token: @session_current.token)
      if product = Product.find_by(name: params[:name])
        render json: product, status: 200
      else
        product = Product.all
        render json: product, status: 200
      end
    else
      render json: "Expired Session", status: 200
    end
  end

  # GET /products/1
  def show
    if Session.find_by(token: @session_current.token)
      if product = Product.find_by(id: params[:id])
      render json: product, status: 200
      else
        render json: "Product not found", status: 422
      end
    else
      render json: "Expired Session", status: 200
    end
  end

  # POST /products
  def create
    if Session.find_by(token: @session_current.token)
      product = Product.new(product_params)
      if product.save
        render json: product, status: 201
      else
        render json: product.errors, status: 422
      end
    else
      render json: "Expired Session", status: 200
    end
  end

  # PATCH/PUT /products/1
  def update
    if Session.find_by(token: @session_current.token)
      if @product.update(product_params)
      render json: @product, status: 200
      else
        render json: @product.errors, status: :unprocessable_entit
      end
    else
      render json: "Expired Session", status: 200
    end
  end

  # DELETE /products/1
  def destroy
    if Session.find_by(token: @session_current.token)
      @product.destroy
      render json: @product , status: 200
    else
      render json: "Expired Session", status: 200
    end
  end

  protected
  def validate_session_create
    authenticate_or_request_with_http_token do |token, options|
      @session_current = Session.find_by(token: token)
      if @session_current.creation_date > Time.now
        @session_current.update(creation_date: 30.minutes.from_now.to_s)
      else
        @session_current.destroy
      end
    end
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
end
