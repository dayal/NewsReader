require 'spec_helper'

describe FavoriteList do

	let(:user) { FactoryGirl.create(:user) }
  	before do
    	@favoritelist = FavoriteList.new(user_id: user.id)
  	end

  	subject { @favoritelist }

  	it { should respond_to(:user_id) }

  	describe "when user_id is not present" do
    	before { @favoritelist.user_id = nil }
    	it { should_not be_valid }
  	end	
end