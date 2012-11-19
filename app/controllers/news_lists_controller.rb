class NewsListsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:create, :edit, :update, :destroy, :remove_feed]

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
    @articles.sort! { |a, b|  a.published_at <=> b.published_at }
  end

  def new
  	@user = User.find(params[:user_id])
  	@news_list = NewsList.new
  end

  def create
  	@news_list = NewsList.new(name: params[:news_list][:name])
    @user.news_lists << @news_list
  	if @news_list.save
      params[:news_list][:feeds][1..-1].each do |feed_id|
        @feed = Feed.find(feed_id)
        @news_list.feeds << @feed if @feed
      end
      feeds_url = params[:news_list][:feeds_url]
      if feeds_url != ""
        @feed = Feed.find_by_feed_url(feeds_url)
        if @feed
          @news_list.feeds << @feed
        else
          @news_list.feeds << Feed.create(feed_url: feeds_url)
        end
      end
  		redirect_to @user
  		flash[:success] = "News list created"
  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:user_id])
  	@news_list = NewsList.find(params[:id])
  end

  def update
    @news_list = NewsList.find(params[:id])
  	if @news_list.update_attributes(name: params[:news_list][:name])
      params[:news_list][:feeds][1..-1].each do |feed_id|
        @feed = Feed.find(feed_id)
        @news_list.feeds << @feed if @feed
      end
      feeds_url = params[:news_list][:feeds_url]
      if feeds_url != ""
        @feed = Feed.find_by_feed_url(feeds_url)
        if @feed
          @news_list.feeds << @feed
        else
          @news_list.feeds << Feed.create(feed_url: feeds_url)
        end
      end
  		flash[:success] = "News list updated"
  		redirect_to @user
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@news_list = NewsList.find(params[:id])
  	@news_list.delete
  end

  def remove_feed
    @news_list = NewsList.find(params[:id])
    @feed = Feed.find(params[:feed_id])
    @news_list.delete(@feed)
    redirect_to edit_user_news_list_path(@user, @news_list)
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
