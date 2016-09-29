class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @completion_status_options = ["New", "Pending", "Completed"]
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    #delete task from array of hashes or db
    redirect_to tasks_path
  end

end

private
  def task_params
    params.require(:task).permit(:name, :description, :completion_status, :completion_date)
  end
