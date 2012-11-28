require 'spec_helper'

describe NewsList do
	let(:user) { FactoryGirl.create(:user) }
	before { @newslist = user.news_lists.build(name: "Example Newslist") }

	subject {@newslist}

	it {should respond_to(:name)}
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }
	its(:user) { should == user }
	it { should be_valid }

	describe "when name is not present" do
	      before { @newslist.name = " " }
	      it { should_not be_valid }
	end

	describe "when user_id is not present" do
    	before { @newslist.user_id = nil }
    	it { should_not be_valid }
  	end

  	describe "accessible attributes" do
    	it "should not allow access to user_id" do
      		expect do
        		NewsList.new(user_id: user.id)
      		end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    	end    
  	end
end
