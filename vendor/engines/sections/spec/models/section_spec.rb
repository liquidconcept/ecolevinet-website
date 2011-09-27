require 'spec_helper'

describe Section do

  def reset_section(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @section.destroy! if @section
    @section = Section.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_section
  end

  context "validations" do
    
    it "rejects empty title" do
      Section.new(@valid_attributes.merge(:title => "")).should_not be_valid
    end

    it "rejects non unique title" do
      # as one gets created before each spec by reset_section
      Section.new(@valid_attributes).should_not be_valid
    end
    
  end

end
