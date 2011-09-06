Given /^I have no actualites$/ do
  Actualite.delete_all
end

Given /^I (only )?have actualites titled "?([^\"]*)"?$/ do |only, titles|
  Actualite.delete_all if only
  titles.split(', ').each do |title|
    Actualite.create(:title => title)
  end
end

Then /^I should have ([0-9]+) actualites?$/ do |count|
  Actualite.count.should == count.to_i
end
