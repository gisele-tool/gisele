require 'spec_helper'
module Gisele::Language::Syntax
  describe Grammar, 'if_st' do

    it 'parses a single if statement' do
      expr = 'if goodCond Task end'
      parse(expr, :if_st).should eq(expr)
    end

    it 'supports an optional else' do
      expr = 'if goodCond GoodTask else BadTask end'
      parse(expr, :if_st).should eq(expr)
    end

    it 'supports an optional elsif clauses' do
      expr = 'if goodCond GoodTask elsif otherCond OtherTask elsif yetAnother BadTask end'
      parse(expr, :if_st).should eq(expr)
    end

  end
end
