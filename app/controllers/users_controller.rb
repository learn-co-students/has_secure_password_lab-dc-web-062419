class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:new, :create]

  def new
    render :new
  end

  def create
    if user_params[:password] == user_params[:password_confirmation]
      @user = User.create(user_params)
      @user.authenticate(params[:password])
        session[:name] = @user.name
        session[:user_id] = @user.id
        render :home
    else
      redirect_to '/signup'
    end
  end

  def show
    render 'home'
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
