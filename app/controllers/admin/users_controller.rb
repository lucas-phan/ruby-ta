class Admin::UsersController < ApplicationController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy ]
  before_action :permission
  layout 'admin/_main' 

  def index

      # @admin_users = Admin::User.where(role: 1)
      @admin_users = Admin::User.all.order(id: :desc).limit(50)
      if params[:role] != nil
        if params[:role].empty?
         @admin_users = Admin::User.order(id: :desc)
       else
         @admin_users = Admin::User.order(id: :desc).where(role: params[:role])
       end   
       
     end  
     
   end  


  def show
  end


  def new
    @admin_user = Admin::User.new
  end


  def edit
  end


  def create
    @admin_user = Admin::User.new(admin_user_params)

    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to @admin_user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @admin_user }
      else
        format.html { render :new }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to @admin_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_user }
      else
        format.html { render :edit }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = Admin::User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params.require(:admin_user).permit(:name, :password, :password_confirmation, :email, :contact, :address, :company, :status, :role)
    end
  end
