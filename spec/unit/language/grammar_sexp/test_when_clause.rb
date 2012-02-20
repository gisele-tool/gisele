require 'spec_helper'
module Gisele::Language
  describe "the Sexp grammar", "when_clause" do

    let(:g){ SEXP_GRAMMAR }

    it 'matches a valid when clause' do
      when_clause = \
        [:when_clause, [:bool_expr, [:bool_lit, true]], [:nop_st]]
      (g[:when_clause] === when_clause).should be_true
    end

  end
end