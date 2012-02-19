require 'spec_helper'
module Gisele::Language::Syntax
  describe Grammar, 'when_clause' do

    it 'parses a single when clause statement' do
      expr = 'when goodCond Task'
      parse(expr, :when_clause).should eq(expr)
    end

    it 'supports a boolean expression' do
      expr = 'when not(goodCond and badCond) Task'
      parse(expr, :when_clause).should eq(expr)
    end

    it 'supports an complex process statement' do
      expr = 'when goodCond Task1 par Task2 Task3 end'
      parse(expr, :when_clause).should eq(expr)
    end

  end
end
