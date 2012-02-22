require 'spec_helper'
module Gisele::Language::Syntax
  describe ParSt, "to_ast" do

    it 'parses as expected' do
      expr     = "par Task1 Task2 end"
      expected = [:par_st, [:task_call_st, "Task1"], [:task_call_st, "Task2"]]
      ast(expr, :par_st).should eq(expected)
    end

  end
end