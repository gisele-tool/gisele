require 'spec_helper'
module Gisele::Language::Syntax
  describe Grammar, 'task_start_or_end' do

    it 'parses correct event names' do
      parse('Task:start', :task_start_or_end).should eq('Task:start')
      parse('Task:end',   :task_start_or_end).should eq('Task:end')
    end

    it 'raises on simple task names' do
      lambda{
        parse('Task', :task_start_or_end)
      }.should raise_error(Citrus::ParseError)
    end

  end
end
