# spec/factories/article.rb

FactoryGirl.define do
  	factory :article do
    	title 'Article Title'
    	body 'This is the body of the article'
  	end

  	factory :user do
		name "Michael Hartl"
		email "michael@example.com"
		password "foobar"
		password_confirmation "foobar"
	end
end
