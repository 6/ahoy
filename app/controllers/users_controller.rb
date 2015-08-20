class UsersController < ApplicationController
  def edit
    @user = current_user!
  end

  def update
    @user = current_user!
    if @user.update(user_params)
      redirect_to_back notice: 'Saved!'
    else
      render :edit
    end
  end

private

  def user_params
    params.require(:user).permit(:given_name, :surname)
  end
end
