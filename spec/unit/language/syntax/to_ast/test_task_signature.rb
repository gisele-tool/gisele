require 'spec_helper'
module Gisele::Language::Syntax
  describe TaskSignature, "to_ast" do

    it 'parses as expected' do
      expr     = "fluent diagKnown {}, {}\ntrackvar mplus {}"
      expected = \
        [ :task_signature,
          [:fluent, "diagKnown", [:event_set], [:event_set], nil],
          [:trackvar, "mplus", [:event_set], [:event_set], nil]]
      ast(expr, :task_signature).should eq(expected)
    end

  end
end
