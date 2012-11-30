require 'spec_helper'

describe "feedslist pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "feedslist creation" do
    before { visit new_user_feeds_list_path(user) }

    describe "with invalid information" do

      it "should not create a feedslist" do
        expect { click_button "Create FeedsList" }.not_to change(FeedsList, :count)
      end

      describe "error messages" do
        before { click_button "Create FeedsList" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'Name', with: "Lorem ipsum" }
      it "should create a feedslist" do
        expect { click_button "Create FeedsList" }.to change(FeedsList, :count).by(1)
      end
    end
  end

  describe "feedslist destruction" do
    before { FactoryGirl.create(:feeds_list, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a feedslist" do
        expect { click_link "Delete FeedsList" }.to change(FeedsList, :count).by(-1)
      end
    end
  end

  describe "feedslist edit" do
    before { FactoryGirl.create(:feeds_list, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a feedslist" do
        expect { click_link "Edit FeedsList" }.to change(FeedsList, :count).by(0)
      end
    end
  end
end