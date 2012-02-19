require 'spec_helper'
module Gisele::Language::Syntax
  describe Grammar, 'boolean_literal' do

    it 'parses booleans' do
      parse('true',  :boolean_literal).should eq('true')
      parse('false', :boolean_literal).should eq('false')
    end

    it 'does not parses integers' do
      lambda{
        parse('0', :boolean_literal)
      }.should raise_error(Citrus::ParseError)
    end

  end
end
