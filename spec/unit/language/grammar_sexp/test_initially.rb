require 'spec_helper'
module Gisele::Language
  describe "the Sexp grammar", "initially" do

    it 'matches true' do
      (sexp_grammar[:initially] === true).should be_true
    end

    it 'matches false' do
      (sexp_grammar[:initially] === false).should be_true
    end

    it 'matches nil' do
      (sexp_grammar[:initially] === nil).should be_true
    end

  end
end