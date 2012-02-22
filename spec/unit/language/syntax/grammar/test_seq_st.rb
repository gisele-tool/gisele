require 'spec_helper'
module Gisele::Language
  describe Grammar, 'seq_st' do

    it 'parses a single sequence statement' do
      expr = 'seq Task1 Task2 end'
      parse(expr, :seq_st).should eq(expr)
    end

  end
end
