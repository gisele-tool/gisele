require 'spec_helper'
module Gisele::Language
  describe "the Sexp grammar", "fluent_def" do

    let(:g){ Gisele::Language }

    it 'matches an fluent with initial value' do
      fluent = [:fluent_def, "name", [:event_set, "start"], [:event_set, "stop"], true]
      (sexp_grammar[:fluent_def] === fluent).should be_true
    end

    it 'matches an fluent without initial value' do
      fluent = [:fluent_def, "name", [:event_set, "start"], [:event_set, "stop"], nil]
      (sexp_grammar[:fluent_def] === fluent).should be_true
    end

  end
end