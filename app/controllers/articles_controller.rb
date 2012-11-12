class ArticlesController < ApplicationController	
    def index
      @articles = Article.find(:all, order: "published_at DESC")
    end

    def show 
    	@article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "That article could not be found"
      redirect_to root_url
    end
end
