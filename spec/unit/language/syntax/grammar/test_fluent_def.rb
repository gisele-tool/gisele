require 'spec_helper'
module Gisele::Language
  describe Grammar, 'fluent_def' do

    it 'parses valid fluent definitions' do
      defn = 'fluent diagKnown {Diagnosis:start}, {Treatment:end} initially false'
      parse(defn, :fluent_def).should eq(defn)
    end

    it 'supports a missing initial value' do
      defn = 'fluent diagKnown {Diagnosis:start}, {Treatment:end}'
      parse(defn, :fluent_def).should eq(defn)
    end

    it 'supports empty sets for events' do
      defn = 'fluent diagKnown {}, {} initially true'
      parse(defn, :fluent_def).should eq(defn)
    end

  end
end