class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :validate_session, only: [:index, :show, :update, :destroy, :productsUser, :productsHome, :transactionUserReq, :transactionUserOffe, :logOut]


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

# For all responses in this controller, return the CORS access control headers.
end
