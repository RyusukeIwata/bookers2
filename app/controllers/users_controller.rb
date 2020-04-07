class UsersController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  def edit
  	@user = User.find(params[:id])
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "User info was successfully updated"
      redirect_to user_path
    else
      render action: :edit
    end
  end
  private
    def user_params
        params.require(:user).permit(:name, :profile_image, :introduction, :password, :password_confirmation)
    end
    def correct_user
        @user = User.find(params[:id])
        if current_user != @user
          redirect_to user_path(current_user.id)
        end
    end
end
