require 'spec_helper'
module Gisele::Language
  describe Grammar,'task_name' do

    it 'parses correct task names' do
      parse('A',          :task_name).should eq('A')
      parse('Diagnosis',  :task_name).should eq('Diagnosis')
      parse('TaskName',   :task_name).should eq('TaskName')
      parse('Task_Name',  :task_name).should eq('Task_Name')
    end

    it 'raises on invalid task names' do
      lambda{
        parse('not_a_task_name', :task_name)
      }.should raise_error(Citrus::ParseError)
    end

  end
end
