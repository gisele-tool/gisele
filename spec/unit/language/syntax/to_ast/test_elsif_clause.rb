require 'spec_helper'
module Gisele::Language::Syntax
  describe ElsifClause, "to_ast" do

    it 'parses as expected' do
      expr     = "elsif goodCond Task1"
      expected = \
        [:elsif_clause,
          [:bool_expr, [:var_ref, "goodCond"]],
          [:task_call_st, "Task1"]]
      ast(expr, :elsif_clause).should eq(expected)
    end

  end
end
