Given /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.create!(article)
  end
end

When /I try to go to article that does not exist/ do
  visit "/articles/12332"
end
