require 'spec_helper'
module Gisele::Language
  describe Grammar, 'spacing' do

    it 'parses all kind of spaces' do
      parse(' ', :spacing).should eq(' ')
      parse("\t", :spacing).should eq("\t")
      parse("\n", :spacing).should eq("\n")
      parse(" \t\n", :spacing).should eq(" \t\n")
    end

    it 'does not enforces mandatory spacing' do
      parse('', :spacing).should eq('')
    end

  end
end