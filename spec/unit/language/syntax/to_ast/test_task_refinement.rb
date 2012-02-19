require 'spec_helper'
module Gisele::Language::Syntax
  describe TaskRefinement, "to_ast" do

    it 'parses as expected' do
      expr     = "refinement Task1 end"
      expected = [:task_refinement, [:task_call_st, "Task1"]]
      ast(expr, :task_refinement).should eq(expected)
    end

  end
end
