class Admin::OptionsController < ApplicationController
  before_action :set_admin_option, only: [:show, :edit, :update, :destroy]
  before_action :permission
  layout 'admin/_main' 


  def index
     @admin_options = Admin::Option.all.order(id: :desc).limit(50).where(group: 'homepage')
     @admin_options_group = Admin::Option.all.order(id: :desc).select(:group).distinct
     ### fifter by group
     if params[:group] != nil
        if params[:group].empty?
            @admin_options = Admin::Option.order(id: :desc) 
        else
            @admin_options = Admin::Option.order(id: :desc).where(group: params[:group])
			@choseparam = params[:group]
        end   
     end 
     # fifter by key  
     if params[:key] != nil
        if params[:key].empty?
            @admin_options = Admin::Option.order(id: :desc) 
        else
            @admin_options = Admin::Option.order(id: :desc).where("key LIKE ?" , "%" + params[:key] + "%")
        end    
     end      
  
  end


  def show
  end
  
  def mailconfig
      @admin_options = Admin::Option.all.order(id: :desc).where("key LIKE ?" , "%" + "mail_server" + "%").limit(50)  
      mailtest = params[:mailtest]  
      if params[:mailtest] != nil  
          sendmail(mailtest,"Test mail from admin","Thank you, This meesage test.")         
      end    
  end 

  # make new plugin here
  # make new plugin here
  
   def shipping_fee
      @admin_options = Admin::Option.where("id = ?" , 44)    
  end

  def payment_setting
      @admin_options = Admin::Option.where(id: [46,45,47,48,51,49])
  end


  def slice_portfolio
      @admin_option = Admin::Option.find(29)
  end

   def lite_pro_gallery
       @admin_option = Admin::Option.find(35)
   end

   def solution_sub_page
       @admin_option = Admin::Option.find(37)
   end

   def solution_benefit
       @admin_option = Admin::Option.find(38)
   end

   def slide_home
          @admin_option = Admin::Option.find(40)
      end

      def about_track
                @admin_option = Admin::Option.find(41)
            end



  def newg
       @admin_option = Admin::Option.new 
  end
        

  def new
    @admin_option = Admin::Option.new
    @admin_options_group = Admin::Option.all.order(id: :desc).select(:group).distinct
  end

  def edit
    @admin_options_group = Admin::Option.all.order(id: :desc).select(:group).distinct
  end


  def create
    @admin_option = Admin::Option.new(admin_option_params)

    respond_to do |format|
      if @admin_option.save
        format.html { redirect_to admin_options_path, notice: 'Option was successfully created.' }
        format.json { render :show, status: :created, location: @admin_option }
      else
        format.html { render :new }
        format.json { render json: @admin_option.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @admin_option.update(admin_option_params)
        format.html { redirect_to admin_options_url, notice: 'Option was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_option }
      else
        format.html { render :edit }
        format.json { render json: @admin_option.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @admin_option.destroy
    respond_to do |format|
      format.html { redirect_to admin_options_url, notice: 'Option was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_option
      @admin_option = Admin::Option.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_option_params
      params.require(:admin_option).permit(:key, :value, :group)
    end
end
