require 'spec_helper'
module Gisele::Language::Syntax
  describe TrackvarDef, "to_ast" do

    it 'converts tracking variable definitions as expected' do
      defn     = "trackvar mplus {Diagnosis:start}"
      expected = [:trackvar,
                   "mplus",
                   [:event_set, "Diagnosis:start"],
                   [:event_set],
                   nil]
      ast(defn, :trackvar_def).should eq(expected)
    end

    it 'supports obsolete events and initial value' do
      defn     = "trackvar mplus {Diagnosis:start}, {Treatment:end} initially true"
      expected = [:trackvar,
                   "mplus",
                   [:event_set, "Diagnosis:start"],
                   [:event_set, "Treatment:end"],
                   true]
      ast(defn, :trackvar_def).should eq(expected)
    end

  end
end
