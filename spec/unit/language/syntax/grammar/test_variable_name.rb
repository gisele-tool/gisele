require 'spec_helper'
module Gisele::Language
  describe Grammar, 'variable_name' do

    it 'parses correct variable names' do
      parse('a',         :variable_name).should eq('a')
      parse('diagnosis', :variable_name).should eq('diagnosis')
      parse('varName',   :variable_name).should eq('varName')
    end

    it 'does not allow reserved words' do
      Gisele::Language::RESERVED_WORDS.each do |word|
        lambda{
          parse(word.to_s + " ", :variable_name)
        }.should raise_error(Citrus::ParseError)
      end
    end

    it 'allows a reserved word as prefix' do
      parse('ifSomething', :variable_name).should eq('ifSomething')
    end

    it 'raises on invalid variable names' do
      lambda{
        parse('NotAVarName', :variable_name)
      }.should raise_error(Citrus::ParseError)
    end

  end
end
