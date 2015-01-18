class UsersController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def show
    @user = User.find(params[:id])
    respond_with @user, api_template: @template
  end

  def index
    @users = User.all
    respond_with @users, api_template: @template, root: 'users'
  end

  def create
    @user = User.create_by_admin(user_create_params)
    respond_with @user, api_template: @template
  end

  def update
    @user = current_user
    if @user.update_password(user_update_params)
      sign_in @user, bypass: true
    end
    respond_with @user, api_template: @template
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_with @user, api_template: @template
  end

  private

  def user_create_params
    params.require(:user).permit(:email)
  end

  def user_update_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
