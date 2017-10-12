class Admin::ArticlesController < ApplicationController
  before_action :set_admin_article, only: [:show, :edit, :update, :destroy]
  before_action :permission
  layout 'admin/_main'

  def index
    @admin_articles = Admin::Article.all.order(id: :desc) 
    @admin_articlenodes_list = Admin::Catalogue.all.order(id: :desc)     
  end

  def show
    @admin_articlenodes_list = Admin::Catalogue.all.order(id: :desc) 
  end

  def new
    @admin_article = Admin::Article.new
    @admin_articlenodes_list = Admin::Catalogue.all.order(id: :desc) 
  end


  def edit
    @admin_articlenodes_list = Admin::Catalogue.all.order(id: :desc) 
  end


  def create
    @admin_article = Admin::Article.new(admin_article_params)

    respond_to do |format|
      if @admin_article.save
        format.html { redirect_to @admin_article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @admin_article }
      else
        format.html { render :new }
        format.json { render json: @admin_article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_article.update(admin_article_params)
        format.html { redirect_to @admin_article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_article }
      else
        format.html { render :edit }
        format.json { render json: @admin_article.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @admin_article.destroy
    respond_to do |format|
      format.html { redirect_to admin_articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_article
      @admin_article = Admin::Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_article_params
      params.require(:admin_article).permit(:title, :image, :content, :status, :node, :order)
    end
end
