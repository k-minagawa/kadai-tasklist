class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:destroy]
  before_action :require_anonymous_user, only: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "新しくユーザー登録されました"
      session[:user_id] = @user.id
      redirect_to tasks_url
    else
      flash.now[:danger] = "ユーザー登録に失敗しました"
      render :new
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "ユーザーは削除されました"
    session[:user_id] = nil
    redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
