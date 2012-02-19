require 'spec_helper'
module Gisele::Language::Syntax
  describe Grammar, 'while_st' do

    it 'parses a single while statement' do
      expr = 'while badCond Task end'
      parse(expr, :while_st).should eq(expr)
    end

  end
end
