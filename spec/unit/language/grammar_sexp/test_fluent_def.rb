require 'spec_helper'
module Gisele::Language
  describe "the Sexp grammar", "fluent_def" do

    let(:g){ SEXP_GRAMMAR }

    it 'matches an fluent with initial value' do
      fluent = [:fluent_def, "name", [:event_set, "start"], [:event_set, "stop"], true]
      (g[:fluent_def] === fluent).should be_true
    end

    it 'matches an fluent without initial value' do
      fluent = [:fluent_def, "name", [:event_set, "start"], [:event_set, "stop"], nil]
      (g[:fluent_def] === fluent).should be_true
    end

  end
end