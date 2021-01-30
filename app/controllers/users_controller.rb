class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :destroy]
  def show
    @user = User.find(params[:id])
    @practice = current_user.practices.build  # form_with 用
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if current_user == @user
    if @user.update(user_params)
      flash[:success] = '正常に更新されました'
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = '更新に失敗しました'
      render :edit
    end
    else
       redirect_to root_url
    end
  end
  
  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    flash[:success] = '退会しました。'
    redirect_to root_url
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page])
    counts(@user)
  end

  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
end
