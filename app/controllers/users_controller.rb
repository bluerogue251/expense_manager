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

  rescue_from PG::CheckViolation do
    flash[:error] = "User job title assignments have overlapping dates"
    redirect_to edit_user_path(@user)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :default_currency,
                                 job_title_assignments_attributes: [:id,
                                                                    :department_id,
                                                                    :job_title_id,
                                                                    :starts_on,
                                                                    :ends_on,
                                                                    :_destroy])
  end
end
