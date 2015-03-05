require "spec_helper"
require "ngo_controller"

describe Ngo do
  it "is named XYZ Company" do
    ngo = Ngo.new
    ngo.name.should == 'XYZ Company'
  end
end
