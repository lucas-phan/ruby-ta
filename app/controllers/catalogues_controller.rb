class CataloguesController < ApplicationController
  before_action :set_catalogue, only: [:show]


  def index
    @catalogues = Catalogue.all
  end

  def show
     @catalogue = Catalogue.friendly.find(params[:id])
     @titlepage = @catalogue.name.capitalize
  end

  def new
    @catalogue = Catalogue.new
  end


  def edit
  end


  def create
    @catalogue = Catalogue.new(catalogue_params)

    respond_to do |format|
      if @catalogue.save
        format.html { redirect_to @catalogue, notice: 'Catalogue was successfully created.' }
        format.json { render :show, status: :created, location: @catalogue }
      else
        format.html { render :new }
        format.json { render json: @catalogue.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @catalogue.update(catalogue_params)
        format.html { redirect_to @catalogue, notice: 'Catalogue was successfully updated.' }
        format.json { render :show, status: :ok, location: @catalogue }
      else
        format.html { render :edit }
        format.json { render json: @catalogue.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalogue
      @catalogue = Catalogue.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalogue_params
      params.require(:catalogue).permit(:name, :fullname ,:image,:intro, :parent, :order, :level, :slug)
    end
end
