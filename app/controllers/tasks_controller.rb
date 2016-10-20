class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :complete, :destroy]
  before_action :require_login

  def index
    @user = User.find(session[:user_id])
    @tasks = Task.where(owner_id: session[:user_id])
  end

  def show
    # Code that needs work to be functional--cannot get to the 404 or show view with applicable test cases:
    # @unsorted_task = Task.find(params[:id])
    # if @unsorted_task.owner_id != session[:user_id]
    #   render file: "#{Rails.root}/public/403.html", layout: false, status: 403
    # else ActiveRecord::RecordNotFound
    #   render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    # end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.owner_id = session[:user_id]
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit; end

  def update
    @task.owner_id = session[:user_id]
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def complete
    @task.mark_complete
    @task.save
    redirect_to tasks_path
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end
end

private

def find_task
  @task = Task.find_by(id: params[:id], owner_id: session[:user_id])
end

def task_params
  params.require(:task).permit(:name, :description, :completion_status, :completion_date)
end
