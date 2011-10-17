require 'spec_helper'

describe NewsItem do

  def reset_news_item(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @news_item.destroy! if @news_item
    @news_item = NewsItem.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_news_item
  end

  context "validations" do
    
    it "rejects empty title" do
      NewsItem.new(@valid_attributes.merge(:title => "")).should_not be_valid
    end

    it "rejects non unique title" do
      # as one gets created before each spec by reset_news_item
      NewsItem.new(@valid_attributes).should_not be_valid
    end
    
  end

end