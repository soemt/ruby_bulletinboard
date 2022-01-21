class AuthController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:login][:email].downcase)
    
    if user && user.authenticate(params[:login][:password_digest]) 
      if params[:remember]
        cookies.permanent[:user_id] = user.id.to_s
      elsif
        cookies[:user_id] = {:value => user.id.to_s, :expires => 1.month}
      end
      
      redirect_to posts_path, notice: 'Successfully logged in!'

    else
      flash[:error] = "Invalid Username or Password"
      redirect_to login_path
    end
  end
  
  def destroy
    cookies.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"
  end

  def signup
    @user = User.new
  end
  
  def create_user
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        @login_user = User.find_by(email: @user.email)
        cookies[:user_id] = {:value => @login_user.id.to_s, :expires => 1.month}
        format.html { redirect_to profile_path(@user), notice: "Successfully created account." }
        format.json { render :profile, status: :created, location: @user }
      else
        format.html { render :signup, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :role, :phone, :address, :dob, :created_user_id, :updated_user_id, :deleted_user_id)
  end

end
