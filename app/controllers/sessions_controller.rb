class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      handle_login user
    else
      flash.now[:danger] = t(".invalid_email_password_combination")
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  def login user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_back_or user
  end

  private
  def handle_login user
    if user.activated
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:warning] = t(".account_not_actived")
      redirect_to root_path
    end
  end
end
