require 'spec_helper'
module Gisele::Language
  describe "the Sexp grammar", "initially" do

    let(:g){ SEXP_GRAMMAR }

    it 'matches true' do
      (g[:initially] === true).should be_true
    end

    it 'matches false' do
      (g[:initially] === false).should be_true
    end

    it 'matches nil' do
      (g[:initially] === nil).should be_true
    end

  end
end