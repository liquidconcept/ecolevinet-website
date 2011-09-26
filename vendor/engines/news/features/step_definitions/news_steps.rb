Given /^I have no news$/ do
  News.delete_all
end

Given /^I (only )?have news titled "?([^\"]*)"?$/ do |only, titles|
  News.delete_all if only
  titles.split(', ').each do |title|
    News.create(:title => title)
  end
end

Then /^I should have ([0-9]+) news?$/ do |count|
  News.count.should == count.to_i
end
