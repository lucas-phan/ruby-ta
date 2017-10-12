class SessionsController < ApplicationController
  layout 'admin/_login'  
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    role = User.find_by_role(params[:role]) 
    # null = guest , 1 : client , 2: admin 
    if user && user.authenticate(params[:password]) && user.role == 2
      session[:user_id] = user.id
      session[:user_role] = 2 
      redirect_to admin_url 
    elsif user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      session[:user_role] = 1
      redirect_to root_url 
    else  
       #render :new , notice: 'Logged out!'
       redirect_to login_url, notice: 'Login fail, Please check email and password again .'
    end   
  end 
  def destroy 
    session[:user_id] = nil
    session[:user_role] = nil
    redirect_to root_url, notice: ''   #'Logged out!'
  end
  
  def facebook 
     if request.post?
       id = params["id"].to_s 
       name = params["name"].to_s 
       email = params["email"].to_s 
       spass = [*('a'..'z')].sample(18).join
       user = User.find_by_email(email)
       if user
        session[:user_id] = user.id 
        session[:user_role] = 1
        render :text => "Login facebook success."  
      else  
       begin           
        @user = User.new
        @user.name = name
        @user.email = email
        @user.password =  spass 
        #@user.type = "facebook"
        @user.role = 1 
        @user.status = 1
        if @user.save
          render :text => 'Create account success.'  
        else  
         render :text => @user.errors
       end 
     rescue => ex
      render :text => "Error, please check and try again."
    end
   end  
  end  
	#render :layout => false 
 end
 
 
end
