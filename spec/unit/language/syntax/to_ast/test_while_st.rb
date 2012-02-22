require 'spec_helper'
module Gisele::Language::Syntax
  describe WhileSt, "to_ast" do

    it 'parses as expected' do
      expr     = "while goodCond Task1 end"
      expected = \
        [:while_st,
          [:bool_expr, [:var_ref, "goodCond"]],
          [:task_call_st, "Task1"]]
      ast(expr, :while_st).should eq(expected)
    end

    it 'recognizes implicit sequences' do
      expr     = "while goodCond Task1 Task2 end"
      expected = \
        [:while_st,
          [:bool_expr, [:var_ref, "goodCond"]],
          [:seq_st, [:task_call_st, "Task1"], [:task_call_st, "Task2"]]]
      ast(expr, :while_st).should eq(expected)
    end

  end
end