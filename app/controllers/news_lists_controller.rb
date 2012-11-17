class NewsListsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user,   only: [:edit, :update]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def add_feed
  end

  def remove_feed
  end
end