class UsersController < ApplicationController
  def edit
    find_user
  end

  def update
    find_user
    if @user.update(user_params)
      flash[:success] = "User profile updated"
      redirect_to [:edit, @user]
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :default_currency)
  end
end
