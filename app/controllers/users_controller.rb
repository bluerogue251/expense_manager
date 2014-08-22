class UsersController < ApplicationController
  def edit
    find_user
    @user.job_title_assignments.build
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
    params.require(:user).permit(:name,
                                 :email,
                                 :default_currency,
                                 job_title_assignments_attributes: [:id, :department_id, :job_title_id, :starts_on, :ends_on, :_destroy])
  end
end
