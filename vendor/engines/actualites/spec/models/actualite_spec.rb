require 'spec_helper'

describe Actualite do

  def reset_actualite(options = {})
    @valid_attributes = {
      :id => 1,
      :title => "RSpec is great for testing too"
    }

    @actualite.destroy! if @actualite
    @actualite = Actualite.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_actualite
  end

  context "validations" do
    
    it "rejects empty title" do
      Actualite.new(@valid_attributes.merge(:title => "")).should_not be_valid
    end

    it "rejects non unique title" do
      # as one gets created before each spec by reset_actualite
      Actualite.new(@valid_attributes).should_not be_valid
    end
    
  end

end