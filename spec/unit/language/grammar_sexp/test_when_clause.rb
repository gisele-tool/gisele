require 'spec_helper'
module Gisele::Language
  describe "the Sexp grammar", "when_clause" do

    it 'matches a valid when clause' do
      when_clause = \
        [:when_clause, [:bool_expr, [:bool_lit, true]], [:nop_st]]
      (sexp_grammar[:when_clause] === when_clause).should be_true
    end

  end
end