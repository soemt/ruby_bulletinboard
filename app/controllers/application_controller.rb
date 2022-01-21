class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    # ----- add these lines here: -----

  # Make the current_user method available to views also, not just controllers:
  helper_method :current_user, :is_Admin
  
  # Define the current_user method:
  def current_user
    # Look up the current user based on user_id in the session cookie:
    #if cookies[:user_id]
    #  @current_user ||= User.find(session[:user_id]) if session[:user_id]
    #end
    @current_user ||= User.find(cookies[:user_id]) if cookies[:user_id]

  end

  def is_Admin
    if @current_user.role == '0'
        @is_Admin = true
    end
  end
  # ----- end of added lines -----

  # authroize method redirects user to login page if not logged in:
  def authorize
    redirect_to login_path, alert: 'You must be logged in to access this page.' if current_user.nil?
  end

end
