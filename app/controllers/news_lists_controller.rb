class NewsListsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:edit, :update, :destroy, :add_feed, :remove_feed]

  def index
  	@user = User.find(params[:user_id])
  	@news_lists = @user.news_lists
  end

  def show
  	@user = User.find(params[:user_id])
  	@news_list = NewsList.find(params[:id])
  	@feeds = @news_list.feeds
    @articles = []
    @feeds.each do |feed|
      @articles << feed.articles
    end
    @articles.sort_by{|article| article[:published_at]}
  end

  def new
  	@user = User.find(params[:user_id])
  	@news_list = NewsList.new
  end

  def create
  	@news_list = NewsList.new(params[:news_list][:feeds])
  	if @news_list.save
  		redirect_to @news_list
  		flash[:success] = "News list created"
  	else
  		render 'new'
  	end
  end

  def edit
  	@news_list = NewsList.find(params[:id])
  end

  def update
  	if @news_list.update_attributes(params[:news_list])
  		flash[:success] = "News list updated"
  		redirect_to @news_list
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@news_list = NewsList.find(params[:id])
  	@news_list.delete
  end

  def add_feed_from_url
  	@feed = Feed.find_by_url(params[:feed_url])
  	if @feed
  		@news_list.feeds << @feed
  	else
  		@feed = Feed.create(feed_url: params[:feed_url])
  		@news_list.feeds << @feed
  	end
  	render 'show'
  end

  def add_feeds
    @feed = Feed.find_by_url(params[:feed_url])
    if @feed
      @news_list.feeds << @feed
    else
      @feed = Feed.create(feed_url: params[:feed_url])
      @news_list.feeds << @feed
    end
    render 'show'
  end

  def remove_feed
  	@feed = Feed.find_by_url(params[:feed_url])
  	if @feed
  		@news_list.feeds.delete(@feed)
  	end
  	render 'show'
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Only signed in users can access this page. Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
