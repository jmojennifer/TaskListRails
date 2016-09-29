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
    #insert task into array of hashes or db
    redirect_to tasks_path
  end

  def destroy
    #delete task from array of hashes or db
    redirect_to tasks_path
  end

end
