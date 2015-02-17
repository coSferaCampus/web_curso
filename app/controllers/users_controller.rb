class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource except: [:create, :update]

  respond_to :json

  def show
    respond_with @user, respond_parameters
  end

  def index
    @users = User.all
    respond_with @users, respond_parameters
  end

  def create
    authorize! :create, User
    @user = User.create_by_admin(user_create_params)
    @user.save
    respond_with @user, respond_parameters
  end

  def update
    @user = current_user
    if @user.update_password(user_update_params)
      sign_in @user, bypass: true
    end
    respond_with @user
  end

  def destroy
    @user.destroy
    respond_with @user
  end

  private

  def user_create_params
    params.require(:user).permit(:email)
  end

  def user_update_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
