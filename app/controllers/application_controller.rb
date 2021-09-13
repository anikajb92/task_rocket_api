class ApplicationController < ActionController::API

  before_action :authenticate

  def authenticate
    auth_header = request.headers[:Authorization]
    if !auth_header
      render json: {error: 'Auth bearer token header is required'}, status: :forbidden
    else 
      token = auth_header.split(' ')[1]
      secret = 'She knows everything about everyone.'
      begin
        decoded_token = JWT.decode token, secret
        payload = decoded_token.first
        @user = User.find payload['user_id'] #instance variable that can be carried across methods
      rescue 
        render json: {error: 'Unrecognized auth bearer token'}, status: :forbidden
      end
    end 
  end
end
