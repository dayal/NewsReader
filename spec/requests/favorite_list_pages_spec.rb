require 'spec_helper'

describe "favorite list pages" do

	subject { page }
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }
  let(:article) { FactoryGirl.create(:article) }

  describe "create favorite list" do
  	before {visit article_path(article)}
    it {should have_link('Add to Favorite')}


    describe "visit profile page without favorite list" do
      before { visit user_path(user) }
      it { should_not  have_selector('h5', text: 'Favorite Articles') }
    end

    describe "visit profile page" do
      before do
        click_link 'Add to Favorite'
        visit user_path(user)
      end
      it { should have_selector('h5', text: 'Favorite Articles') }
      it {should have_link('Delete')}

      describe "delete a article" do
        before {click_link 'Delete'}
        it { should_not  have_selector('h5', text: 'Favorite Articles') }
      end
    end
  end
end

