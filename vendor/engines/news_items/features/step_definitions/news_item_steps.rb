Given /^I have no news_items$/ do
  NewsItem.delete_all
end

Given /^I (only )?have news_items titled "?([^\"]*)"?$/ do |only, titles|
  NewsItem.delete_all if only
  titles.split(', ').each do |title|
    NewsItem.create(:title => title)
  end
end

Then /^I should have ([0-9]+) news_items?$/ do |count|
  NewsItem.count.should == count.to_i
end
