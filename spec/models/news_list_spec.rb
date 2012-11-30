require 'spec_helper'

describe FeedsList do
	let(:user) { FactoryGirl.create(:user) }
	before { @feedslist = user.feeds_lists.build(name: "Example Newslist") }

	subject {@feedslist}

	it {should respond_to(:name)}
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	its(:user) { should == user }
	it { should be_valid }

	describe "when name is not present" do
	      before { @feedslist.name = " " }
	      it { should_not be_valid }
	end

	describe "when user_id is not present" do
    	before { @feedslist.user_id = nil }
    	it { should_not be_valid }
  	end

  	describe "accessible attributes" do
    	it "should not allow access to user_id" do
      		expect do
        		FeedsList.new(user_id: user.id)
      		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    	end    
  	end
end
