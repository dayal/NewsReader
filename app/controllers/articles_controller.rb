class ArticlesController < ApplicationController	
    def index
      @articles = Article.find(:all, order: "published_at DESC")
    end

    def show 
    	@article = Article.find(params[:id])
      @content = "There is no content"
      if !@article.content.nil?
        @content = Article.extract_paragraphs(@article.content.sanitize)
      elsif !@article.summary.nil?
        @content = Article.extract_paragraphs(@article.summary.sanitize)
      end
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "That article could not be found"
      redirect_to root_url
    end
end
