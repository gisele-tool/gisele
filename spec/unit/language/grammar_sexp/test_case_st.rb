require 'spec_helper'
module Gisele::Language
  describe "the Sexp grammar", "case_st" do

    it 'matches when no variable is specified' do
      case_st = \
        [:case_st, nil,
          [:when_clause, [:bool_expr, [:bool_lit, true]], [:nop_st]] ]
      (sexp_grammar[:case_st] === case_st).should be_true
    end

    it 'matches when a variable is specified' do
      case_st = \
        [:case_st, [:var_ref, "varName"],
          [:when_clause, [:bool_expr, [:bool_lit, true]], [:nop_st]] ]
      (sexp_grammar[:case_st] === case_st).should be_true
    end

  end
end