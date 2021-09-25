class TasksController < ApplicationController

  def index
    @task = Task.all
    render json: @task, status: :created
  end

  def categories
    @categories = Task.categories
    render json: @categories, status: :ok
  end 

  def create 
    byebug
    @new_task = Task.new task_params
    @new_task.user = @user 

    byebug

    if @new_task.valid?
      @new_task.save
      render json: @new_task, status: :created
    else
      render json: { errors: @new_task.errors.full_messages}, status: :unprocessable_entity 
    end 
  end


  private 
    def task_params 
      params.require(:task).permit(:description, :priority, :completed, :category)
    end 
    
end
