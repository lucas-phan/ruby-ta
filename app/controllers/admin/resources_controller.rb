class Admin::ResourcesController < ApplicationController
  before_action :set_admin_resource, only: [:show, :edit, :update, :destroy]
  before_action :permission
  layout 'admin/_main'  
  
  def index
    @limit = 20 
    @admin_resources = Admin::Resource.all.order(id: :desc).limit(@limit)
    
    @include = params['page']
    @count = Admin::Resource.all.order(id: :desc).count 
    if @count > @limit      
      if @include != nil                    
       @admin_resources = Admin::Resource.all.order(id: :desc).limit(@limit.to_i).offset(@include.to_i * @limit.to_i)     
     end   
     if @include == nil
       @include = 0
     end  
     @totalpage = (@count.to_f / @limit.to_f).ceil
     @nextpage =""
     for i in 0..(@totalpage-1) 
      @nextpage += "<a class=" + (i== @include.to_i ? '"paging active"' : '"paging"') + " href='"+request.path.split('/').last+"?page="+i.to_s+"'>["+(i+1).to_s+"]</a>&nbsp; " 
     end
             
    end
    if params[:ids] != nil    
           for id in params[:ids] 
               filedelete(id)
           end
           Admin::Resource.destroy(params[:ids])  
           @notice =  " Deleted " + params[:ids].size.to_s + " item."         
    end   
  end

  def getvaluebyid(id)
      @admin_resource = Admin::Resource.find(id)
  end  
 
  def filedelete(id)
        file_del =  getvaluebyid(id).value
        file_path = 'public/uploads/'+file_del
        File.delete(file_path) if File.exist?(file_path) 
  end 


  def show
  end


  def new
    @admin_resource = Admin::Resource.new
  end


  def edit

  end 

  def popup
    @limit = 20
    @admin_resources = Admin::Resource.all.order(id: :desc).where(group: 'image').limit(@limit) 
    @include = params['page']
    @count = Admin::Resource.all.order(id: :desc).count 
    if @count > @limit      
      if @include != nil                    
       @admin_resources = Admin::Resource.all.order(id: :desc).limit(@limit.to_i).offset(@include.to_i * @limit.to_i)     
     end   
     if @include == nil
       @include = 0
     end  
     @totalpage = (@count.to_f / @limit.to_f).ceil
     @nextpage =""
     @link_=   request.env['ORIGINAL_FULLPATH']
     for i in 0..(@totalpage-1) 
      @nextpage += "<a class=" + (i== @include.to_i ? '"paging active"' : '"paging"') + " href='"+@link_+"&page="+i.to_s+"'>["+(i+1).to_s+"]</a>&nbsp; " 
    end
           
  end
  render layout: "admin/_simple"   
end


  def create
    if params['admin_resource'][:value].to_s.empty?       
     begin
      uploaded_io = params['attachment'][:file]
      for i in 0.. (uploaded_io.count - 1)
        @admin_resource = Admin::Resource.new(admin_resource_params)  
                  # @admin_resource = Admin::Resource.new(:value => 'xx',:group => 'img')

                  filename_ = Time.now.strftime("%y%m%d%H%M")+"-"+uploaded_io[i].original_filename.gsub(/[^.a-zA-Z0-9\-]/,"-").downcase
                  File.open(Rails.root.join('public', 'uploads', filename_), 'wb') do |file|
                   file.write(uploaded_io[i].read)          
                 end       
                 @admin_resource.value =  filename_.to_s

                 @admin_resource.save
               end 

             rescue
              @admin_resource = Admin::Resource.new(admin_resource_params) 
              @admin_resource.value
            end     
          else
            @admin_resource = Admin::Resource.new(admin_resource_params) 
            @admin_resource.value
          end   

          respond_to do |format|

            if @admin_resource.save

              format.html {  redirect_to admin_resources_path, notice: 'Resource was successfully created.' }
              format.json { render :show, status: :created, location: @admin_resource }
            else
              format.html { render :new }
              format.json { render json: @admin_resource.errors, status: :unprocessable_entity }
            end   
          end   

        end 


  def create_old
    @admin_resource = Admin::Resource.new(admin_resource_params)

    if @admin_resource.value.to_s.empty?
      uploaded_io = params[:admin_resource][:file]
      if uploaded_io != nil
      	filename_ = Time.now.strftime("%Y%m%d%H%M")+"-"+uploaded_io.original_filename.gsub(/[^.a-zA-Z0-9\-]/,"-").downcase
        File.open(Rails.root.join('public', 'uploads', filename_), 'wb') do |file|
          file.write(uploaded_io.read)  
        end  
        @admin_resource.value = filename_ 
      end  
    else
      @admin_resource.value
    end  

    respond_to do |format|

      if @admin_resource.save
        format.html { redirect_to @admin_resource, notice: 'Resource was successfully created.' }
        format.json { render :show, status: :created, location: @admin_resource }
      else
        format.html { render :new }
        format.json { render json: @admin_resource.errors, status: :unprocessable_entity }
      end
    end
  end


  def update

    respond_to do |format|

    
      if @admin_resource.update(admin_resource_params)
        format.html { redirect_to @admin_resource, notice: 'Resource was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_resource }
      else
        format.html { render :edit }
        format.json { render json: @admin_resource.errors, status: :unprocessable_entity }
      end 
    end 
  end


  def destroy
    @admin_resource.destroy

     file_del = @admin_resource.value
    file_path = 'public/uploads/'+file_del
    File.delete(file_path) if File.exist?(file_path)
    
    respond_to do |format|
      format.html { redirect_to admin_resources_url, notice: 'Resource was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_resource
      @admin_resource = Admin::Resource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_resource_params
      params.require(:admin_resource).permit(:value, :group)
    end
  end 
