class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  layout 'admin/_login'

  def index
    @users = User.all.order(id: :desc)
  end

  def show
  end


  def new
    @user = User.new
  end  

  def edit
  end
  @@code = 'xcode'
  def getpass    
     @geturl = request.host
     @email = params["email"]
     @user =   User.find_by_email(@email)
     if @email != nil
       if @user != nil 
            @showform = true
            @token_obj = @email.to_s + @@code.to_s  + Time.now.to_i.to_s[0..7]
            @token = Digest::SHA1.hexdigest(@token_obj)       
            linkchangepass =  'http://' + @geturl +'/newpass?email='+@email.to_s+'&token='+@token.to_s   
            @conents =  '<p>You or somebody request new password.</p><p>Your email: ' + @email + '</p><p><a href="'+linkchangepass+'">If you want change password click here.</a></p> <p>If you not change password , please skip this email.</p><br>'
            sendmail(@email,"Reset Password account?",@conents)              
        else
            @info = 'This email not found.'
            @showform = false  
        end   
      end
                  
   end   

   def newpass    
              @email = params["email"]
              @token = params["token"]
              @user =   User.find_by_email(@email)
              @token_obj = @email.to_s + @@code.to_s  + Time.now.to_i.to_s[0..7]
              @token_ = Digest::SHA1.hexdigest(@token_obj)  
              if @email != nil && @token != nil
                if  @token == @token_
                  if @user != nil 
                    @info = 'You can change your password here.'
                    @showform = true
                  else
                    @info = 'This email not found in system.'
                    @showform = false 
                  end 
                else
                  @info = 'Link exprired or wrong, If you want change password , please back login and reset again .'
                  @showform = false 
                end
              else
                @info = 'You not permission , please back to login page.'
                return "login" 
                @showform = false 

              end

   end 

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to login_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end 


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email, :contact, :address, :company, :status, :role)
    end
  end
