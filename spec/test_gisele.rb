require File.expand_path('../spec_helper', __FILE__)
describe Gisele do

  it "should have a version number" do
    Gisele.const_defined?(:VERSION).should be_true
  end

end
