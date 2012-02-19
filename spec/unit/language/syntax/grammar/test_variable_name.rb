require 'spec_helper'
module Gisele::Language::Syntax
  describe Grammar, 'variable_name' do

    it 'parses correct variable names' do
      parse('a',         :variable_name).should eq('a')
      parse('diagnosis', :variable_name).should eq('diagnosis')
      parse('varName',   :variable_name).should eq('varName')
    end

    it 'raises on invalid variable names' do
      lambda{
        parse('NotAVarName', :variable_name)
      }.should raise_error(Citrus::ParseError)
    end

  end
end
