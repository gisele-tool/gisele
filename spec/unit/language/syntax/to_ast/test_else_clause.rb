require 'spec_helper'
module Gisele::Language::Syntax
  describe ElseClause, "to_ast" do

    it 'parses as expected' do
      expr     = "else Task1"
      expected = \
        [:else_clause, [:task_call_st, "Task1"]]
      ast(expr, :else_clause).should eq(expected)
    end

  end
end
