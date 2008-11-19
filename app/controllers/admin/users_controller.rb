class Admin::UsersController < ApplicationController
  
  layout "admin"
  before_filter :admin_required
  
  def index
    @users = User.all :order=>"login ASC"
    @page_title = "Users"
  end
  
  # def show
  #   unless @user = User.find(params[:id])
  #     redirect_to admin_users_path
  #   end
  # end
  
  def new
    @user = User.new
    @page_title = "New User"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User created"
      redirect_to admin_users_path
    else
      flash[:error] = "Could not create user"
      redirect_to new_admin_user_path
    end
  end

  def edit
    if @user = User.find(params[:id])
      @page_title = "Edit " + @user.name
    else
      redirect_to admin_users_path
    end
  end

  def update
    if @user = User.find(params[:id])
      logger.info "\n>>>>>\n#{params[:user]}\n<<<<<<\n"
      if @user.update_attributes(params[:user])
        flash[:notice] = "User updated"
        redirect_to admin_users_path
      else
        flash[:error] = "Could not update user"
        redirect_to edit_admin_user_path(@user)
      end
    else
      redirect_to admin_users_path 
    end
  end

  def destroy
    if @user = User.find(params[:id])
      if @user.destroy
        flash[:notice] = "User destroyed"
      else
        flash[:error] = "Could not destroy #{@user.name}"
      end
    end
    redirect_to admin_users_path 
  end

  # def suspend
  #   @user.suspend! 
  #   redirect_to users_path
  # end
  # 
  # def unsuspend
  #   @user.unsuspend! 
  #   redirect_to users_path
  # end
  # 
  # def destroy
  #   @user.delete!
  #   redirect_to users_path
  # end
  # 
  # def purge
  #   @user.destroy
  #   redirect_to users_path
  # end
  
end
