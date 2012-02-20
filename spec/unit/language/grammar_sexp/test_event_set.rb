require 'spec_helper'
module Gisele::Language
  describe "the Sexp grammar", "event_set" do

    it 'matches an empty set' do
      (sexp_grammar[:event_set] === [:event_set]).should be_true
    end

    it 'matches a non empty set' do
      (sexp_grammar[:event_set] === [:event_set, "event", "Task:start"]).should be_true
    end

  end
end