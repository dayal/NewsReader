Given /the following articles exist/ do |articles_table|
  articles_table.hashes.each do |article|
    Article.send(:attr_accessible, :title, :author, :summary)
    Article.create!(:article)
  end
end
