require 'spec_helper'
module Gisele::Language::Syntax
  describe TaskDef, "to_ast" do

    it 'parses an explicit definition as expected' do
      expr = <<-EXPR.strip
        task Task1
          fluent diagKnown {}, {}
          Task2
        end
      EXPR
      expected = \
        [:task_def, "Task1",
          [:fluent, "diagKnown", [:event_set], [:event_set], nil],
          [:task_call_st, "Task2"]]
      ast(expr, :task_def).should eq(expected)
    end

    it 'uses :nop_st if no statement' do
      expr = <<-EXPR.strip
        task Task1
          fluent diagKnown {}, {}
        end
      EXPR
      expected = \
        [:task_def, "Task1",
          [:fluent, "diagKnown", [:event_set], [:event_set], nil],
          [:nop_st]]
      ast(expr, :task_def).should eq(expected)
    end

    it 'uses :nop_st when empty' do
      expr = <<-EXPR.strip
        task Task1
        end
      EXPR
      expected = \
        [:task_def, "Task1",
          [:nop_st]]
      ast(expr, :task_def).should eq(expected)
    end

  end
end
