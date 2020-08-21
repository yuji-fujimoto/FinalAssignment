class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:index, :show, :edit]
  # before_action :correct_user, only: [:show, :edit, :update]
  def index
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to items_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      flash[:success] = 'ユーザ設定を更新しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ設定は更新されませんでした'
      render :edit
    end
  end
  
end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation, :max_tops, :max_outer, :max_pants, :max_bag, :max_shoes)
end