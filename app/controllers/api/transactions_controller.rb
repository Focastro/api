module Api
  class TransactionsController < ApplicationController
    before_action :set_transaction, only: [:show, :edit, :update, :destroy]
    before_action :validate_session, only: [:create]

  # GET /transactions
  def index
    if Session.find_by(token: @session_current.token)
      transactions = Transaction.all
      if transactions != []
        render json: transactions, status: 200
      else
        render json: "Empty transactions", status: 422
      end
    else
      render json: "Expired Session", status: 200
    end
  end

  # POST /transactions
  def create
    if Session.find_by(token: @session_current.token)
      transaction = Transaction.new(transaction_params)
      if product_offered = Product.find_by(id: params[:product_offered_id]) && product_req = Product.find_by(id: params[:product_req_id])
        Product.update(product_offered.id, :id_user => product_req.id_user)
        Product.update(product_req.id, :id_user => product_offered.id_user)
        transaction.save
        render json: "Transaction ready", status: 200
      else
        render json: "Incorrect data", status: 422
      end
    else
      render json: "Expired Session", status: 200
    end
  end

  protected
  def validate_session
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
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:product_req_id, :product_offered_id)
    end
  end
end
