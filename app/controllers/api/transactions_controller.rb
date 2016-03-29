module Api
  class TransactionsController < ApplicationController
    before_action :set_transaction, only: [:show, :edit, :update, :destroy]

  # GET /transactions
  # GET /transactions.json
  def index
    transactions = Transaction.all
    if transactions != []
      render json: transactions, status: 200
    else
      render json: "Empty transactions", status: 422
    end
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions
  # POST /transactions.json
  def create
    transaction = Transaction.new(transaction_params)

    if product_offered = Product.find_by(id: params[:product_offered_id]) && product_req = Product.find_by(id: params[:product_req_id])
      Product.update(product_offered.id, :id_user => product_req.id_user)
      Product.update(product_req.id, :id_user => product_offered.id_user)
      transaction.save
      render json: "Transaction ready", status: 200
    else
      render json: "Incorrect data", status: 422
    end

  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:product_req_id, :product_offered_id)
    end
  end
end
