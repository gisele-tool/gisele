require 'spec_helper'
module Gisele::Language::Syntax
  describe BoolExpr, "to_ast" do

    it 'is correctly extended by Sexpr' do
      ast("true", :bool_expr).should be_a(Gisele::Language::AST::BoolExpr)
    end

    it 'returns expected ast on simple expressions' do
      expected = \
        [:bool_expr, [:bool_and, [:var_ref, "diagKnown"], [:var_ref, "platLow"]]]
      ast("diagKnown and platLow", :bool_expr).should eq(expected)
    end

    it 'respects priorities' do
      expected = [:bool_expr,
        [:bool_or, [:bool_and, [:var_ref, "diagKnown"], [:var_ref, "platLow"]], [:var_ref, "platHigh"]]]
      ast("diagKnown and platLow or platHigh", :bool_expr).should eq(expected)
    end

    it 'supports double negations' do
      expected = [:bool_expr, [:bool_not, [:bool_not, [:var_ref, "diagKnown"]]]]
      ast("not not(diagKnown)", :bool_expr).should eq(expected)
    end

    it 'makes boolean literals explicit' do
      ast("true",  :bool_expr).should eq([:bool_expr, [:bool_lit, true]])
      ast("false", :bool_expr).should eq([:bool_expr, [:bool_lit, false]])
    end

  end
end