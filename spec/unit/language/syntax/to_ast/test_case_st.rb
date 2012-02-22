require 'spec_helper'
module Gisele::Language::Syntax
  describe CaseSt, "to_ast" do

    it 'arranges when clauses as expected' do
      expr = <<-CASE_ST.strip
        case
        when good
          Task1
        when bad
          Task2
        end
      CASE_ST
      when_clause1 = ast("when good Task1", :when_clause)
      when_clause2 = ast("when bad Task2", :when_clause)
      expected = [:case_st, nil, when_clause1, when_clause2]
      ast(expr, :case_st).should eq(expected)
    end

    it 'puts the else clause at the end' do
      expr = <<-CASE_ST.strip
        case
        when good
          Task1
        else
          Task2
        end
      CASE_ST
      when_clause = ast("when good Task1", :when_clause)
      else_clause = ast("else Task2", :else_clause)
      expected = [:case_st, nil, when_clause, else_clause]
      ast(expr, :case_st).should eq(expected)
    end

    it 'supports an optional variable name' do
      expr = <<-CASE_ST.strip
        case someVariable
        when good
          Task1
        end
      CASE_ST
      expected = [:var_ref, "someVariable"]
      ast(expr, :case_st)[1].should eq(expected)
    end

  end
end