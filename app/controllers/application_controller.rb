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
        JWT.decode token, secret        
      rescue 
        render json: {error: 'Unrecognized auth bearer token'}, status: :forbidden
      end
    end 
  end
end
