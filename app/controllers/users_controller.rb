class UsersController < ApplicationController
  
  skip_before_action :authenticate, only: [:create, :login]

  def index
    @users = User.all 
    render json: @users, status: :ok
  end 

  def profile
    render json: @user, status: :ok # can add 'include key value pair' here (but need to set up relationships first)
  end 

  def create
    @user = User.create user_params
    render json: @user, status: :created
  end 

  def login
    @user = User.find_by username: params[:user][:username]

    if !@user
      render json: {error: 'Invalid username or password'}, status: :unauthorized
    else

      if !@user.authenticate params[:user][:password]
        render json: {error: 'Invalid username or password'}, status: :unauthorized
      else
        payload = {user_id: @user.id}
        secret = 'She knows everything about everyone.'
        @token = JWT.encode payload, secret
        render json: {token: @token}, status: :ok
      end
    end 
  end 

  private #PRIVATE!! 

  def user_params
    params.require(:user).permit(:username, :password)
  end 
end