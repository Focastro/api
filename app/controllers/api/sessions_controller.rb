module Api
  class SessionsController < ApplicationController
    before_action :set_session, only: [:edit, :update, :destroy]

  # GET /sessions
  # GET /sessions.json
  def index
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
    if @session_current.destroy
      render json: "Logout", status: 200
    else
      render json: "Logout Error", status: 422
    end
  end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions
  # POST /sessions.json
  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])

      if Session.find_by(username: params[:username])
        session_verify = Session.find_by(username: params[:username])
        session = Session.update(session_verify.id, :creation_date => 30.minutes.from_now.to_s)
        render json: session, status: 200
      else
        session = Session.new(:username => user.username, :creation_date => 30.minutes.from_now.to_s)
        session.save
        render json: session, status: 200
      end
    else
      render json: "User or password invalid", status: 422
    end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { render :show, status: :ok, location: @session }

      else
        format.html { render :edit }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
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
