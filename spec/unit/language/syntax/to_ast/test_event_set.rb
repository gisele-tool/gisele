require 'spec_helper'
module Gisele::Language::Syntax
  describe EventSet, "to_ast" do

    it 'converts empty lists as expected' do
      expr     = '{ }'
      expected = [:event_set]
      ast(expr, :event_set).should eq(expected)
    end

    it 'converts singleton lists as expected' do
      expr     = '{Diagnosis:start}'
      expected = [:event_set, "Diagnosis:start"]
      ast(expr, :event_set).should eq(expected)
    end

    it 'converts non empty lists as expected' do
      expr     = '{Diagnosis:start, an_event, another_one}'
      expected = [:event_set, "Diagnosis:start", "an_event", "another_one"]
      ast(expr, :event_set).should eq(expected)
    end

  end
end
