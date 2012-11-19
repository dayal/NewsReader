require 'spec_helper'

describe NewsList do
	before do
		@newslist = NewsList.new(name: "Example Newslist")
	end

	subject {@newslist}

	it {should respond_to(:name)}

	describe "when name is not present" do
	      before { @newslist.name = " " }
	      it { should_not be_valid }
	end
end
