class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # Sends email to user when user is created.
      session[:id] = @user.id
      flash[:success] = "user Added!"
      @user.send_welcome_email
      redirect_to products_path
    else
      flash[:danger] = "user has errors!"
      render :new
    end
  end


  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

end
