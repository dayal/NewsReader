# spec/factories/article.rb

FactoryGirl.define do
  	factory :article do
    	title 'Article Title'
    	body 'This is the body of the article'
  	end


	factory :user do
    	sequence(:name)  { |n| "Person #{n}" }
    	sequence(:email) { |n| "person_#{n}@example.com"}   
    	password "foobar"
    	password_confirmation "foobar"

    	factory :admin do
      		admin true
    	end
  	end

  	factory :feeds_list do
    	name "Example Newslist"
    	user
  	end
end
