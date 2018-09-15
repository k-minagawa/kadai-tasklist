class SessionsController < ApplicationController
  before_action :require_user_logged_in, only: [:destroy]
  before_action :require_anonymous_user, only: [:new, :create]
  
  def new
  end

  def create
    email = params[:sessions][:email].downcase
    password = params[:sessions][:password]
    if login(email, password)
      flash[:success] = "ログインしました。"
      redirect_to tasks_url
    else
      flash[:danger] = "ログインに失敗しました。"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = "ログアウトしました。"
    redirect_to root_url
  end
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
  
end
