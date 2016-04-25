module Api
  class SessionsController < ApplicationController
    before_action :set_session, only: [:edit, :update, :destroy]

  # GET /sessions/1
  def show
    if @session_current.destroy
      render json: "Logout", status: 200
    else
      render json: "Invalid token", status: 422
    end
  end

  # POST /sessions
  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session = Session.new(:username => user.username, :creation_date => 30.minutes.from_now.to_s)
      session.save
      render json: session.as_json.merge(:id_user => user.id), status: 200
    else
      render json: "User or password invalid", status: 422
    end
  end

  # DELETE /sessions/1
  def destroy
    @session.destroy
    render json: "Logout", status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(:username, :token, :creation_date)
    end
  end
end
