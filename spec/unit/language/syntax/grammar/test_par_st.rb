require 'spec_helper'
module Gisele::Language
  describe Grammar, 'par_st' do

    it 'parses a single parallel statement' do
      expr = 'par Task1 Task2 end'
      parse(expr, :par_st).should eq(expr)
    end

  end
end