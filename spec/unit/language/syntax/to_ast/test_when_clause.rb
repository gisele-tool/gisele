require 'spec_helper'
module Gisele::Language::Syntax
  describe WhenClause, 'to_ast' do

    it 'converts a when clause as expected' do
      expr = 'when goodCond Task'
      expected = \
        [:when_clause,
          [:bool_expr, [:var_ref, "goodCond"] ],
          [:task_call_st, "Task"]]
      ast(expr, :when_clause).should eq(expected)
    end

  end
end