require 'spec_helper'

describe NewsListsController do
	before :each do
		@user = User.create(:name => 'examasde', :email => 'sadasd@yahoo.com', :password => 'dddddd', :password_confirmation => 'dddddd')
		sign_in(@user)
	end
	describe 'showing a newslist' do
		it 'should display the newslist'  do
		   @user.news_lists << NewsList.create(name: 'asdasd')
		   news_list = @user.news_lists.first
		   get :show, {user_id: @user.id, id: news_list.id}
		   assert_response :success
		end
	end
	describe 'new newslist page' do
		it 'should display the new newslist page'  do
		   NewsList.should_receive(:new)
		   get :new, {user_id: @user.id}
		end
	end
	describe 'create newslist' do
		it 'should save the newslist'  do
		   assert_difference('NewsList.count') do
		     post :create, {user_id: @user.id, news_list: {name: 'asda', is_private: false, feeds: [""]}}
		   end
		end
	end
	describe 'edit newslist' do
		it 'should display the edit newslist page'  do
			 @user.news_lists << NewsList.create(name: 'asdasd')
		   news_list = @user.news_lists.first
		   get :edit, {user_id: @user.id, id: news_list.id}
		   assert_response :success
		end
	end
	describe 'update newslist' do
		it 'should update the newslist'  do
			 @user.news_lists << NewsList.create(name: 'asdasd')
		   news_list = @user.news_lists.first
		   post :update, {user_id: @user.id, id: news_list.id, news_list: {name: 'asda', is_private: false, feeds: [""]}}
		end
	end
	describe 'delete newslist' do
		it 'should delete the newslist'  do
			 @user.news_lists << NewsList.create(name: 'asdasd')
		   news_list = @user.news_lists.first
		   get :destroy, {user_id: @user.id, id: news_list.id}
		end
	end
	describe 'remove feed' do
		it 'removes feed'  do
			 @user.news_lists << NewsList.create(name: 'asdasd')
		   news_list = @user.news_lists.first
		   news_list.feeds << Feed.create(feed_url: 'fake')
		   get :remove_feed, {user_id: @user.id, id: news_list.id, feed_id: 1}
		end
	end
end