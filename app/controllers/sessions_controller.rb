class SessionsController < ApplicationController
  def new
  end

  def create
    #If the user exists AND the password entered is correct.
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      #saves the user ID in a cookie
      session[:user_id] = user.id
      redirect_to '/'
    else
      #if the login does not work, send them back to the login form
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
