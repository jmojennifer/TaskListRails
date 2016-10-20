class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :complete, :destroy]
  before_action :require_login

  def index
    @user = User.find(session[:user_id])
    @tasks = Task.where(owner_id: session[:user_id])
  end

  def show; end

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
