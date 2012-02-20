require 'spec_helper'
module Gisele::Language
  describe "the Sexp grammar", "event_set" do

    let(:g){ SEXP_GRAMMAR }

    it 'matches an empty set' do
      (g[:event_set] === [:event_set]).should be_true
    end

    it 'matches a non empty set' do
      (g[:event_set] === [:event_set, "event", "Task:start"]).should be_true
    end

  end
end