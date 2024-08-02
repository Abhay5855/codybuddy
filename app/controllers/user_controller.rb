class UserController < ApplicationController
  skip_before_action :authenticate_user, only: [:new, :create]
  before_action :redirect_if_authenticated, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      Rails.logger.debug "User saved with ID: #{@user.id}"
      session[:user_id] = @user.id
      Rails.logger.debug "Session user_id set to: #{session[:user_id]}"
      redirect_to root_path, flash: { success: "Signed up successfully" }
    else
      Rails.logger.debug "User save failed: #{@user.errors.full_messages.join(', ')}"
      render :new, flash: { error: "Failed to Sign Up" }
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :phone_number)
  end
end
