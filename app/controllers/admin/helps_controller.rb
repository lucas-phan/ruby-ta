class Admin::HelpsController < ApplicationController
  before_action :permission
  layout 'admin/_main' 

  def index
  end  

end
