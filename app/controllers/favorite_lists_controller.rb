class FavoriteListsController < ActionController::Base
	before_filter :signed_in_user

	def show
		@user = User.find(params[:user_id])
		@articles = @user.favorite_list.articles
	end

	def add_article
		@user = User.find(params[:user_id])
		@article = Article.find(params[:article_id])
		if @article
			@user.favorite_list << @article
			flash[:success] = "Article added to favorite list."
			redirect_to @article
		else
			render 'show'
		end
	end

	def remove_article
		@user = User.find(params[:user_id])
		@article = Article.find(params[:article_id])
		if @article
			@user.favorite_list.delete(@article)
			flash[:success] = "Article removed from favorite list."
			redirect_to @user
		else
			render 'show'
		end
	end

	private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Only signed in users can access this page. Please sign in."
      end
    end
end