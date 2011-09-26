require 'spec_helper'

describe news do

  def reset_news(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @news.destroy! if @news
    @news = News.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_news
  end

  context "validations" do
    
    it "rejects empty title" do
      News.new(@valid_attributes.merge(:title => "")).should_not be_valid
    end

    it "rejects non unique title" do
      # as one gets created before each spec by reset_news
      NEws.new(@valid_attributes).should_not be_valid
    end
    
  end

end
