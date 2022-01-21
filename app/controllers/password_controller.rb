class PasswordController < ApplicationController

  def forgot
  end

  def forgot_pw
    if params[:email].blank?
      return render json: {error: 'Email not present'}
    end

    user = User.find_by_email(params[:email].downcase)

    if user.present? 
        user.generate_password_token!
        redirect_to login_path, notice: "Sent email to #{user.email}."
    else
      flash[:error] = "Email Not Found. Please check again."
      redirect_to forgot_url
    end
  end

  def reset
    token = params[:token].to_s
    @user = User.find_by(reset_password_token: token)
  end

  def reset_password
    token = params[:token].to_s

    @user = User.find_by(reset_password_token: token)

    if @user.present? && @user.password_token_valid?
      if password_params[:password] != password_params[:password_confirmation]
          flash[:error] = "Passwords do not match"
          redirect_to reset_url token: token
      else
        if @user.reset_password!(password_params[:password])
          redirect_to login_path, notice: "Your password has been reset successfully."
        else
          render :reset
        end
      end
    else
      redirect_to login_path, notice: "Token is not valid."
      return
    end
  end

  private
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
