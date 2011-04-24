require 'spec_helper'

describe Person do

  let(:person) { Factory.build(:person) }

  describe "validations" do

    it "should create a valid person" do
      person.should be_valid
    end

    it "should require a name" do
      person.name = nil
      person.should_not be_valid
    end
  end
end
