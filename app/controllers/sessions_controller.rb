class SessionsController < ApplicationController
  def new
    render :login
  end

  def create
    @user = User.find_or_create_by(name: session_params[:name])
    if (!session_params[:name].nil? &&
        !session_params[:name].empty? &&
        @user.authenticate(session_params[:password]))
      session[:name] = session_params[:name]
      session[:user_id] = User.find_by(name: session_params[:name]).id
      render :template => 'users/home'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session.delete :name
    redirect_to '/login'
  end

  private

  def session_params
    params.require(:user).permit(:name, :password)
  end
end
