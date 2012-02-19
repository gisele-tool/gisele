require 'spec_helper'
module Gisele::Language::Syntax
  describe Grammar, 'spaces' do

    it 'parses all kind of spaces' do
      parse(' ', :spaces).should eq(' ')
      parse("\t", :spaces).should eq("\t")
      parse("\n", :spaces).should eq("\n")
      parse(" \t\n", :spaces).should eq(" \t\n")
    end

    it 'enforces mandatory spacing' do
      lambda{
        parse('', :spaces)
      }.should raise_error(Citrus::ParseError)
    end

  end
end
