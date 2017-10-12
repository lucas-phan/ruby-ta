class PagesController < ApplicationController
  before_action :set_page, only: [:show ]
  
  def index
    @pages = Page.all.order(id: :desc).where(status: 1)
  end  

  def show
     @pages = Page.friendly.where(status: "1").find(params[:id])
	   @titlepage = @pages.title.capitalize
  end 
  
  def homepage
			 @titlepage ='Trang Chủ'
  end 
 
  def new
    @page = Page.new
  end

  def edit
  end
  
  def contactus
		@titlepage ='Liên Hệ'
          if request.post?
           name_= params["name_"].to_s 
           phone_ = params["phone_"].to_s
           email_ = params["email_"].to_s
           mess_ = params["mess_"].to_s
           subject_ = params["subject_"].to_s
                    begin
                      @contents =  '<p>Thank you, ' + 'We will soon contact to you.</p><p>Email:' + email_ + '</p><p>Phone:' + phone_ + '</p><p>Name: ' + name_ + '</p> <p>Subject: ' + subject_ + '</p>  <p>Message: ' + mess_ + '</p><br>'      
                      sendmailcc(email_,"Contact.",@contents)
                      @thankyou = "<span style='color:#cccc2a;'>Thank you, We will soon contact to you.</span><br><br>"
                    rescue => ex
                     @thankyou = "Error , please check info again and try one more ."
                    end   
          end   
  end


  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:title, :content, :status,:level,:full_title, :parent, :order , :keywords , :template , :show_type , :custom_field  , :description)
    end
end
