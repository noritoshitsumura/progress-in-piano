class PracticesController < ApplicationController
  before_action :require_user_logged_in
  
  
  def new
    @user = current_user
  end
  
  def create
    @user = current_user
    @practice = current_user.practices.build(practice_params)
    if @practice.save
      flash[:success] = '練習時間を登録しました。'
      redirect_to user_path(current_user)
    else
      flash[:danger] = '練習時間を登録して下さい。'
      redirect_to user_path(current_user)
    end
  end
  
  private

  def practice_params
    params.require(:practice).permit(:time)
  end
end
