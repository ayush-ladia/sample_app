class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
    @my_stocks = @user.stocks
  end

  def create
    @user = User.new(params[:user])
    @user.cash_in_hand = 10000;
    @user.total_portfolio = 10000;
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def new
  	@user = User.new
    @user.cash_in_hand = 10000
    @user.total_portfolio = 10000
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end


    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end



end