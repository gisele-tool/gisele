require 'spec_helper'
module Gisele::Language::Syntax
  describe FluentDef, "to_ast" do

    it 'converts fluent definitions as expected' do
      defn     = "fluent diagKnown {Diagnosis:start, diagnosis}, {Treatment:end} initially false"
      expected = [:fluent_def,
                   "diagKnown",
                   [:event_set, "Diagnosis:start", "diagnosis"],
                   [:event_set, "Treatment:end"],
                   false]
      ast(defn, :fluent_def).should eq(expected)
    end

    it 'does not require the initial value' do
      defn     = "fluent diagKnown {Diagnosis:start, diagnosis}, {Treatment:end}"
      expected = [:fluent_def,
                   "diagKnown",
                   [:event_set, "Diagnosis:start", "diagnosis"],
                   [:event_set, "Treatment:end"],
                   nil]
      ast(defn, :fluent_def).should eq(expected)
    end

  end
end