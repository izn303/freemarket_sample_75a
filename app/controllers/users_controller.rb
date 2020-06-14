class UsersController < ApplicationController

  before_action :sign_in

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  end

  def show
  end


  def destroy
    
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname)
  end

  def sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
      flash[:alert] = 'ログインまたはアカウント新規登録をお願いします。'
    end
  end

end