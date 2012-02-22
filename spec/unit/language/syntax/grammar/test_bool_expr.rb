require 'spec_helper'
module Gisele::Language
  describe Grammar, 'bool_expr' do

    it 'parses single variable references' do
      parse('diagKnown', :bool_expr).should eq('diagKnown')
    end

    it 'parses boolean literals' do
      parse('true',  :bool_expr).should eq('true')
      parse('false', :bool_expr).should eq('false')
    end

    it 'parses negated expression' do
      parse('not diagKnown', :bool_expr).should eq('not diagKnown')
      parse('not true', :bool_expr).should eq('not true')
      parse('not false', :bool_expr).should eq('not false')
    end

    it 'parses or expressions' do
      parse('diagKnown or platLow', :bool_expr).should eq('diagKnown or platLow')
    end

    it 'parses and expressions' do
      parse('diagKnown and platLow', :bool_expr).should eq('diagKnown and platLow')
    end

    it 'parses complex expressions' do
      expr = 'diagKnown and (platLow or not(metastased and mplus))'
      parse(expr, :bool_expr).should eq(expr)
    end

  end
end