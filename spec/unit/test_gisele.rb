require 'spec_helper'
describe Gisele do

  it "should have a version number" do
    Gisele.const_defined?(:VERSION).should be_true
  end

end
