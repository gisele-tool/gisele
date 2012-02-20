require 'spec_helper'
module Gisele::Language
  describe "the Sexp grammar", "nop_st" do

    let(:g){ SEXP_GRAMMAR }

    it 'matches [:nop_st]' do
      (g[:nop_st] === [:nop_st]).should be_true
    end

  end
end