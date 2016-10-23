class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:index, :create]

  def create
    auth_hash = request.env['omniauth.auth']
    redirect to login_failure_path unless auth_hash['uid']

    @user = User.find_by(uid: auth_hash[:uid], provider: 'github')
    if @user.nil?
      # User doesn't match anything in the DB.
      # Attempt to create a new user.
      @user = User.build_from_github(auth_hash)
      render :creation_failure unless @user.save
    end

    # Save the user ID in the session
    session[:user_id] = @user.id

    redirect_to tasks_path
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end

  # Once I matched my route and method to #index instead of #login, it broke the site. I found that the site worked the same without this method and I couldn't figure out how to test it, so commented it out.
  # def index
  #   @user = User.find(session[:user_id]) # < recalls the value set in a previous request
  # end
end
