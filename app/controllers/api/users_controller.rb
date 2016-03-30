module Api
  class UsersController < ApplicationController
    before_action :set_user, only: [:update, :destroy]
    before_action :user_params, only: [:create]

  # POST /users
  def create
    user = User.new(user_params)
    if user.save
      render json: user , status: 201
    else
      render json: user.errors, status: 422
    end
  end

  # PATCH/PUT /users/1
  def update
    if Session.find_by(token: @session_current.token)
      if @user.update(user_params)
      render json: @user, status: 200
      else
        render json: @user.errors, status: :unprocessable_entit
      end
    else
      render json: "Expired Session", status: 200
    end
  end

  # DELETE /users/1
  def destroy
    if Session.find_by(token: @session_current.token)
      @user.destroy
      render json: @user , status: 200
    else
      render json: "Expired Session", status: 200
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:username, :password, :password_confirmation, :firstname)
    end
  end
end
