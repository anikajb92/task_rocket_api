class UsersController < ApplicationController

  skip_before_action :authenticate, only: [:create, :login]

  def index
    @users = User.all 
    render json: @users, status: :ok
  end 

  def profile
    render json: {user: @user}, methods: [:user_active], status: :ok # can add 'include key value pair' here (but need to set up relationships first)
  end 

  def allinfo #tasks and stats
    render json: @user,
    methods: [:sorted_tasks, :completed_tasks, :perc_tasks_completed, 
      :num_tasks_per_category, :user_active, :avg_completion_time, 
      :most_productive_day, :most_tasks_per_category, :num_tasks_per_priority], 
    status: :ok
  end 

  def create
    @user = User.create user_params

    if @user
      render json: @user, status: :created
    else 
      render json:{error: 'Oops! Something went wrong. Please check your credentials and try again'}, status: :unprocessable_entity
    end
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
        render json: {token: @token, user: @user}, status: :ok
      end
    end 
  end
  
  def update
    @user = User.find params[:id]
    @user.update firstname: params[:firstname], lastname: params[:lastname] 
    render json: @user, status: :updated
  end 

  def stats 
    render json: @user, 
    methods: [:perc_tasks_completed, :num_tasks_per_category, :user_active] 
  end 

  private #PRIVATE!! 

  def user_params
    params.require(:user).permit(:username, :password, :firstname, :lastname)
  end 
end
