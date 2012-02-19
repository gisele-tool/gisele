require 'spec_helper'
module Gisele::Language::Syntax
  describe ExplicitTaskDef, "to_ast" do

    it 'parses an explicit definition as expected' do
      expr     = "task Task1 fluent diagKnown {}, {} refinement Task2 end end"
      expected = \
        [:task_def, "Task1",
          [:task_signature,
            [:fluent, "diagKnown", [:event_set], [:event_set], nil]],
          [:task_refinement,
            [:task_call_st, "Task2"]]]
      ast(expr, :task_def).should eq(expected)
    end

  end
  describe ImplicitTaskDef, "to_ast" do

    it 'parses an implicit definition as expected' do
      expr     = "task Task1 Task2 end"
      expected = \
        [:task_def, "Task1",
          [:task_signature],
          [:task_refinement,
            [:task_call_st, "Task2"]]]
      ast(expr, :task_def).should eq(expected)
    end

  end
end
