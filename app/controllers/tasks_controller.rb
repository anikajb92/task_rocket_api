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
    @new_task = Task.new task_params
    @new_task.user = @user 
    @data = @task.user.perc_tasks_completed

    if @new_task.valid?
      @new_task.save
      render json: {new_task: @new_task, data: @data}, status: :created
    else
      render json: { errors: @new_task.errors.full_messages}, status: :unprocessable_entity 
    end 
  end

  def update
    @task = Task.find params[:id]
    @task.update task_params
    @data = @task.user.perc_tasks_completed

    if @task.save
      render json: {task: @task, data: @data}, status: :accepted
    else
      render json: {errors: @task.errors.full_messages}, status: :forbidden
    end
  end 

  def destroy
    @task = Task.find params[:id]
    @task.destroy
    @data = @task.user.perc_tasks_completed

    render json: {data: @data, message: 'Successfully deleted'}, status: :ok
  end

  private 
    def task_params 
      params.require(:task).permit(:description, :priority, :completed, :category)
    end 

end
