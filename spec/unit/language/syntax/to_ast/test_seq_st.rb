require 'spec_helper'
module Gisele::Language::Syntax
  describe SeqSt, "to_ast" do

    it 'parses as expected' do
      expr     = "seq Task1 Task2 end"
      expected = [:seq_st, [:task_call_st, "Task1"], [:task_call_st, "Task2"]]
      ast(expr, :seq_st).should eq(expected)
    end

  end
end