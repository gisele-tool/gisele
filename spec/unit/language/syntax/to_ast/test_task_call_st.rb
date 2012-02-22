require 'spec_helper'
module Gisele::Language::Syntax
  describe TaskCallSt, "to_ast" do

    it 'converts a call as expected' do
      ast("Diagnosis", :task_call_st).should eq([:task_call_st, "Diagnosis"])
    end

  end
end