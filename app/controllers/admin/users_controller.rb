class Admin::UsersController < ApplicationController
  http_basic_authenticate_with name: ENV["JUNGLE_USERNAME"], password: ENV["JUNGLE_PASSWORD"]

  def index
    @users = User.order(id: :desc).all
  end

  def show
    @user = User.find params[:id]    
  end


  def destroy
    @user = User.find params[:id]
    if @user != current_user
      @user.destroy
      redirect_to [:admin, :users]
      flash[:notice] = 'User deleted' 
    else
      redirect_to [:admin, :users]
      flash[:notice] = 'Cannot delete an actively logged in user!'
    end
  end
end
