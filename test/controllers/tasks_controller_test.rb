require 'test_helper'

class TasksControllerTest < ActionController::TestCase

  def login_lucy_as_user
    session[:user_id] = users(:lucy_lovestocode).id
    return session[:user_id]
  end

  def find_a_lucy_task_id
    task_id = tasks(:sample_task3).id
    return task_id
  end

  test "(index) Logged in user can see exactly her tasks" do
    login_lucy_as_user

    # Send the request; check the response
    get :index
    assert_response :success
    assert_template :index

    # Check that pages match exactly
    # --Pages owned by this user are returned
    # --Pages not owned by this user are not returned
    tasks_from_controller = assigns(:tasks)
    assert_equal tasks_from_controller.length, users(:lucy_lovestocode).tasks.length

    tasks_from_controller.each do |task|
      assert_includes users(:lucy_lovestocode).tasks, task
    end
  end

  test "(index) Logged in user can see her requested task" do
    login_lucy_as_user
    task_id = task_id = find_a_lucy_task_id

    get :show, { id: task_id }
    assert_response :success
    assert_template :show

    task = assigns(:task)
    assert_not_nil task
    assert_equal task.id, task_id
  end

  test "(new) Logged in user can access the new task page" do
    login_lucy_as_user

    get :new
    assert_response :success
    assert_template :new

    task = assigns(:task)
    assert_not_nil task
    assert_nil task.id
  end

  test "(create) Logged in user can make a new task" do
    login_lucy_as_user
    post_params = { task: { name: "New tests", completion_status: "Pending" } }

    assert_difference('Task.count', 1) do
      post :create, post_params
    end

    assert_response :redirect
    assert_redirected_to tasks_path
  end

  test "(create) A task missing necessary info won't be saved" do
    login_lucy_as_user
    post_params = { task: { name: "New tests" } }

    assert_no_difference('Task.count') do
      post :create, post_params
    end

    get :new
    assert_response :success
  end

  test "(edit) Logged in user can access her task's edit page" do
    login_lucy_as_user
    task_id = find_a_lucy_task_id

    get :edit, { id: task_id }
    assert_response :success
    assert_template :edit

    task = assigns(:task)
    assert_not_nil task
  end

  test "(update) Logged in user can update her task" do
    login_lucy_as_user
    task_id = find_a_lucy_task_id

    updated_name = "New tests!!!!!!"
    updated_completion_status = "In Progress"


    patch :update, id: task_id, task: { name: updated_name, description: "", completion_status: updated_completion_status, completion_date: "", user_id: session[:user_id] }

    task = assigns(:task)
    assert_equal task.name, updated_name
    assert_equal task.completion_status, updated_completion_status

    assert_response :redirect
    assert_redirected_to tasks_path
  end

  test "(update) Logged in user should be returned to the edit page if edit parameters are invalid" do
    login_lucy_as_user
    task_id = find_a_lucy_task_id

    updated_name = nil
    updated_author = "not me"
    updated_completion_status = "In Progress"

    patch :update, id: task_id, task: { name: updated_name, description: "", completion_status: updated_completion_status, completion_date: "", user_id: session[:user_id] }

    task = assigns(:task)
    assert_response :success
    assert_template :edit
  end

  test "(destroy) Logged in user should be able to delete her task" do
    login_lucy_as_user
    task_id = find_a_lucy_task_id

    assert_difference('Task.count', -1) do
      delete :destroy, { id: task_id }
    end

    assert_response :redirect
    assert_redirected_to tasks_path
  end

  test "(complete) Logged in user should be able to complete her task" do
    login_lucy_as_user
    task_id = find_a_lucy_task_id

    patch :complete, { id: task_id }

    assert_response :redirect
    assert_redirected_to tasks_path
  end

  test "(index) 2nd user cannot see 1st user's tasks when logged in" do
    session[:user_id] = users(:carefree_colin).id

    get :index
    assert_response :success
    assert_template :index

    tasks_from_controller = assigns(:tasks)

    assert_not_equal tasks_from_controller.length, users(:lucy_lovestocode).tasks.length

    tasks_from_controller.each do |task|
      assert_not_includes users(:lucy_lovestocode).tasks, task
    end
  end

  test "(show) 2nd user will be redirected to 404 if accessing another user's task" do
    session[:user_id] = users(:no_task_stan).id
    task_id = find_a_lucy_task_id

    get :show, { id: task_id }
    assert_response :not_found
  end

  test "(index) not logged in user should get redirected from tasks" do
    login_lucy_as_user
    session.delete(:user_id)

    get :index
    assert_response :redirect
    assert_redirected_to root_path
  end
end
