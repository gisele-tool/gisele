require 'spec_helper'
module Gisele::Language::Syntax
  describe IfSt, "to_ast" do

    it 'parses as expected' do
      expr     = "if goodCond Task1 end"
      expected = \
        [:if_st,
          [:bool_expr, [:var_ref, "goodCond"]],
          [:task_call_st, "Task1"]]
      ast(expr, :if_st).should eq(expected)
    end

    it 'supports a else clause' do
      expr     = "if goodCond Task1 else Task2 end"
      expected = \
        [:if_st,
          [:bool_expr, [:var_ref, "goodCond"]],
          [:task_call_st, "Task1"],
          [:else_clause, [:task_call_st, "Task2"]] ]
      ast(expr, :if_st).should eq(expected)
    end

    it 'supports elsif clauses' do
      expr     = "if goodCond Task1 elsif otherCond Task2 elsif stillAnother Task3 else Task4 end"
      expected = \
        [:if_st,
          [:bool_expr, [:var_ref, "goodCond"]], [:task_call_st, "Task1"],
          [:elsif_clause,
            [:bool_expr, [:var_ref, "otherCond"]], [:task_call_st, "Task2"]],
          [:elsif_clause,
            [:bool_expr, [:var_ref, "stillAnother"]], [:task_call_st, "Task3"]],
          [:else_clause,
            [:task_call_st, "Task4"]] ]
      ast(expr, :if_st).should eq(expected)
    end

  end
end
