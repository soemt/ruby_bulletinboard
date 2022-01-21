class UsersController < ApplicationController
  before_action :authorize, :current_user, :is_Admin
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    if @is_Admin == true
      @users = User.search_user(params)
                   .where(deleted_user_id: nil)
    else
      @users = User.search_user(params)
                   .where(created_user_id: @current_user).where(deleted_user_id: nil)
    end
  end

  # GET /users/1 or /users/1.json
  def show
    restrict()
  end

  def profile
    set_user()
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    restrict()
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def user_confirm
    @user = User.new(user_params)
    unless @user.valid?
        render :new
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to profile_path(@user), notice: "User was successfully updated." }
        format.json { render :profile, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    if @user.id == @current_user.id
      cookies.delete(:user_id)
      redirect_to login_path, notice: "Logged out!"
    end

    @user.delete_user(@current_user.id)

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def change_password
    @user = User.find_by_name(params[:id])
    restrict()
  end
  
  def update_password
    if !params[:password].present?
      flash[:error] = "Insert your current password."
      redirect_to change_password_url
    elsif current_user.authenticate(params[:password])
      if !params[:new_password].present?
        flash[:error] = "Insert your new password."
        redirect_to change_password_url
      elsif params[:new_password] != params[:confirm_new_password]
        flash[:error] = "New passwords do not match."
        redirect_to change_password_url
      else
        current_user.reset_password!(params[:new_password])
      redirect_to profile_path, notice: "Successfully changed password."
      end
    else
      flash[:error] = "Incorrect current password."
      redirect_to change_password_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_name(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :new_password, :new_password_confirmation, :profile, :role, :phone, :address, :dob, :created_user_id, :updated_user_id, :deleted_user_id)
    end

    def restrict
      if !@is_Admin
        if @user.id == @current_user.id
          
        else
          if @user.created_user_id == @current_user.id
            
          else
            redirect_to users_path
          end
        end
      end
    end
end
