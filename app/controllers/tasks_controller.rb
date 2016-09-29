class TasksController < ApplicationController

  def index
    @name = "Jennifer"

    @all_tasks = [
      {name: "Petcare",
        description: "Give Jassy her dinner and lovins",
        completion_status: "Pending",
        completion_date: nil,
        id: 1
      },
      {
        name: "Homework",
        description: "Do readings and play with zombies",
        completion_status: "Pending",
        completion_date: nil,
        id: 2
      },
      {
        name: "Rest",
        description: "Get some ZZZs",
        completion_status: "Complete",
        completion_date: "9-26-2016",
        id: 3
        }]

  end

  def show
    all_tasks = [
      {name: "Petcare",
        description: "Give Jassy her dinner and lovins",
        completion_status: "Pending",
        completion_date: nil,
        id: 1
        },
        {
        name: "Homework",
        description: "Do readings and play with zombies",
        completion_status: "Pending",
        completion_date: nil,
        id: 2
        },
        {
        name: "Rest",
        description: "Get some ZZZs",
        completion_status: "Complete",
        completion_date: "2016-09-28",
        id: 3
        }]

    @task = all_tasks[params[:id].to_i - 1]
  end

  def new; end

  def create
    #insert task into array of hashes or db
    redirect_to tasks_path
  end

  def destroy
    #delete task from array of hashes or db
    redirect_to tasks_path
  end

end
