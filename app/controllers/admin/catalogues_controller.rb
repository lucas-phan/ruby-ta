class Admin::CataloguesController < ApplicationController
  before_action :set_admin_catalogue, only: [:show, :edit, :update, :destroy]
  before_action :permission
  layout 'admin/_main' 
  
  def index
    @admin_catalogues = Admin::Catalogue.order('COALESCE([group], fullname), [group], fullname')
  end  
 
  def gname(sub) 
    begin
    @admin_catalogues = Admin::Catalogue.find(sub)
    rescue => exception
    end
  end
  helper_method :gname 

  def show

  end

  def new
    @admin_catalogue = Admin::Catalogue.new
    @catalog_list = Admin::Catalogue.all.order('COALESCE([group], fullname), [group], fullname')
  end

  def edit
    @admin_catalogue = Admin::Catalogue.find(params[:id])
    @admin_catalogue.slug =  @admin_catalogue.name.parameterize
    @isself = @admin_catalogue.id
                 @ar1 = @admin_catalogue.id.to_s
                 box = [@admin_catalogue.id] 
                 @catalog_all = Admin::Catalogue.all 
                 @catalog_all.each do |admin_all|
                    @ar2 = eval(admin_all.level)
                    if @ar2.include?(@ar1) 
                        box.push(admin_all.id)  
                    end    
                 end 
        @catalog_list = Admin::Catalogue.where.not(:id => [box]).order('COALESCE([group], fullname), [group], fullname') 
  end

  def create
    @admin_catalogue = Admin::Catalogue.new(admin_catalogue_params)
    @admin_catalogue.slug =  @admin_catalogue.name.parameterize
    @admin_catalogue.level = []
    respond_to do |format|
      if @admin_catalogue.save
        syncat
        format.html { redirect_to @admin_catalogue, notice: 'Catalogue was successfully created.' }
        format.json { render :show, status: :created, location: @admin_catalogue }
      else
        @catalog_list = Admin::Catalogue.all.order('COALESCE([group], fullname), [group], fullname')
        format.html { render :new }
        format.json { render json: @admin_catalogue.errors, status: :unprocessable_entity }
      end
    end
  end

  def update    
    respond_to do |format|
      if @admin_catalogue.update(admin_catalogue_params)   
        syncat 
        format.html { redirect_to @admin_catalogue, notice: 'Catalogue was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_catalogue }
      else
        format.html { render :edit }
        format.json { render json: @admin_catalogue.errors, status: :unprocessable_entity }
      end
    end
  end

  def syncat
         @catalog_all = Admin::Catalogue.all 
           @catalog_all.each do |admin_all|
              @ar = admin_all.id
              #syn level 
              @level_catalogue = Admin::Catalogue.find(@ar)
              level = []
              $rssult = ''
              $group = ''
              $i = @level_catalogue.parent.to_i 
              if $i <= 0 
                  $group = @ar
              end  
              while $i > 0  do
                   $ten = gname($i).id.to_s
                   $full = gname($i).name.to_s
                   $rssult = $full + ' > ' + $rssult
                   $group = $ten
                   level.push($ten)
                   $i = gname($i).parent.to_i;
              end 
              @level_catalogue.level = level
              @level_catalogue.fullname = $rssult + admin_all.name.to_s
              @level_catalogue.group = $group.to_s
              @level_catalogue.save           
           end
  end

  def destroy
    @admin_catalogue.destroy
    @obj = @admin_catalogue.id
    @catalog_all = Admin::Catalogue.where(parent: @obj)
        @catalog_all.each do |admin_all|
              @ar = admin_all.id
              #syn cat delete 
              @level_catalogue = Admin::Catalogue.find(@ar)       
              @level_catalogue.parent = ''
              @level_catalogue.save                
           end 
        syncat
    respond_to do |format|
      format.html { redirect_to admin_catalogues_url, notice: 'Catalogue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_admin_catalogue
      @admin_catalogue = Admin::Catalogue.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_catalogue_params
      params.require(:admin_catalogue).permit(:name,:fullname, :image,:intro, :parent, :order,:group, :level, :slug)
    end
end