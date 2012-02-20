require 'spec_helper'
module Gisele::Language
  describe "the Sexp grammar", "nop_st" do

    it 'matches [:nop_st]' do
      (sexp_grammar[:nop_st] === [:nop_st]).should be_true
    end

  end
end