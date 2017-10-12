class Admin::PagesController < ApplicationController
  before_action :set_admin_page, only: [:show, :edit, :update, :destroy]
  before_action :permission
  layout 'admin/_main'
  
  def index
    @admin_pages = Admin::Page.order('COALESCE([group], full_title), [group], full_title')
  end       

  helper_method :findsub
  def findsub(param)
     @admin_sub = Admin::Page.all.where(parent: param)
  end  
  
  helper_method :findtitle 
  def findtitle(param)
     @admin_page = Admin::Page.find(param) 
  end   

  def gname(sub) 
    begin
    @admin_catalogues = Admin::Page.find(sub)
    rescue => exception
    end
  end
  helper_method :gname 
 
  def show
  end 

  def new
    @admin_page = Admin::Page.new
    @catalog_list = Admin::Page.all.order('COALESCE([group], full_title), [group], full_title')
    @template = Dir[Rails.root+'app/views/pages/*template*'].select{ |f| File.file? f }.map{ |f| File.basename f }
  end

  def edit
	  @admin_page.slug = @admin_page.title.to_slug.normalize! :transliterations => [:vietnamese]
      @template = Dir[Rails.root+'app/views/pages/*template*'].select{ |f| File.file? f }.map{ |f| File.basename f }

          @admin_catalogue = Admin::Page.find(params[:id])
                 @ar1 = @admin_catalogue.id.to_s
                 box = [@admin_catalogue.id] 
                 @catalog_all = Admin::Page.all 
                 @catalog_all.each do |admin_all|
                    @ar2 = eval(admin_all.level)
                    if @ar2.include?(@ar1) 
                        box.push(admin_all.id)  
                    end    
                 end 
        @catalog_list = Admin::Page.where.not(:id => [box]).order('COALESCE([group], full_title), [group], full_title')  
  end 
  
  def create
    @admin_page = Admin::Page.new(admin_page_params)
    @admin_page.slug = @admin_page.title.to_slug.normalize! :transliterations => [:vietnamese]
    @admin_page.level = [] 

    respond_to do |format|
      if @admin_page.save
        syncat
        format.html { redirect_to admin_pages_path, notice: 'Page was successfully created.' }
        format.json { render :show, status: :created, location: @admin_page }
      else
	    @catalog_list = Admin::Page.all.order('COALESCE([group], full_title), [group], full_title') 
        format.html { render :new }
        format.json { render json: @admin_page.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @admin_page.update(admin_page_params)
        syncat
        format.html { redirect_to admin_pages_path, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_page }
      else
        format.html { render :edit }
        format.json { render json: @admin_page.errors, status: :unprocessable_entity }
      end
    end
  end

   def syncat
         @catalog_all = Admin::Page.all 
           @catalog_all.each do |admin_all|
              @ar = admin_all.id
              @level_catalogue = Admin::Page.find(@ar)
              level = []
              $rssult = ''
              $group = ''
              $i = @level_catalogue.parent.to_i 
              if $i <= 0 
                  $group = @ar
              end  
              while $i > 0  do
                   $ten = gname($i).id.to_s
                   $full = gname($i).title.to_s
                   $rssult = $full + ' > ' + $rssult
                   $group = $ten
                   level.push($ten)
                   $i = gname($i).parent.to_i;
              end  
              @level_catalogue.level = level
              @level_catalogue.group = $group.to_s
              @level_catalogue.full_title = $rssult + admin_all.title.to_s
              @level_catalogue.save                
           end       
  end

  def destroy
    @admin_page.destroy
    @obj = @admin_page.id
    @catalog_all = Admin::Page.where(parent: @obj)
        @catalog_all.each do |admin_all|
              @ar = admin_all.id
              @level_catalogue = Admin::Page.find(@ar)       
              @level_catalogue.parent = ''
              @level_catalogue.save                
           end 
        syncat
    respond_to do |format|
      format.html { redirect_to admin_pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_page
      @admin_page = Admin::Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_page_params
      params.require(:admin_page).permit(:title, :content, :status,:level,:full_title,:group, :parent, :slug, :order, :keywords , :template , :show_type , :custom_field , :description, :featureimage)
    end
end
