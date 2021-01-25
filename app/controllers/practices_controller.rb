class PracticesController < ApplicationController
  before_action :require_user_logged_in
  
  
  def new
  end
  
  def create
    @practice = current_user.practices.build(practice_params)
    if @practice.save
      flash[:success] = '練習時間を登録しました。'
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = '練習時間の登録に失敗しました。'
      render 'users/show'
    end
  end
  
  private

  def practice_params
    params.require(:practice).permit(:time)
  end
end
