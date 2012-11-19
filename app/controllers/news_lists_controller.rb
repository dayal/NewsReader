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
    if @news_list.is_private and !current_user?(@user)
      flash[:notice] = "You are trying to access a private newslist"
      redirect_to root_path
    else
  	  @feeds = @news_list.feeds
      @articles = []
      @feeds.each do |feed|
        feed.articles.each do |article|
          @articles << article
        end
      end
      @articles.sort! { |a, b|  a.published_at <=> b.published_at }
    end
  end

  def new
  	@user = User.find(params[:user_id])
  	@news_list = NewsList.new
    @feeds = Feed.all
  end

  def create
  	@news_list = NewsList.new(name: params[:news_list][:name], is_private: params[:news_list][:is_private])
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
    @feeds = Feed.all - @news_list.feeds
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
    flash[:success] = "Successfully deleted '#{@news_list.name}' NewsList"
    redirect_to @user
  end

  def remove_feed
    @news_list = NewsList.find(params[:id])
    @feed = Feed.find(params[:feed_id])
    @news_list.feeds.delete(@feed)
    flash[:success] = "Successfully deleted #{@feed.name} from your NewsList"
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

