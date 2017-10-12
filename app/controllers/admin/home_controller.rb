class Admin::HomeController < ApplicationController
  before_action :permission
  layout 'admin/_main' 

  def index
  	 @options_count = Admin::Option.all.count
  	 @users_count = Admin::User.all.count
  	 @resources_count = Admin::Resource.all.count
  end  

end
