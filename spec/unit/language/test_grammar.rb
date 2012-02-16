require 'spec_helper'
module Gisele::Language
  describe Grammar do

    let(:grammar){ Gisele::Language::Grammar }

    def parse(text, rule, consume = true)
      grammar.parse(text, :root => rule, :consume => consume)
    end

    describe 'the task_name rule' do

      it 'parses correct task names' do
        parse('A',          :task_name).should eq('A')
        parse('Diagnosis',  :task_name).should eq('Diagnosis')
        parse('TaskName',   :task_name).should eq('TaskName')
        parse('Task_Name',  :task_name).should eq('Task_Name')
      end

      it 'raises on invalid task names' do
        lambda{ parse('not_a_task_name',  :task_name) }.should raise_error(Citrus::ParseError)
      end

    end # task_name

    describe 'the variable_name rule' do

      it 'parses correct variable names' do
        parse('a',         :variable_name).should eq('a')
        parse('diagnosis', :variable_name).should eq('diagnosis')
        parse('varName',   :variable_name).should eq('varName')
      end

      it 'raises on invalid variable names' do
        lambda{ parse('NotAVarName',  :variable_name) }.should raise_error(Citrus::ParseError)
      end

    end # variable_name

    describe 'the event_name rule' do

      it 'parses correct event names' do
        parse('a',          :event_name).should eq('a')
        parse('event',      :event_name).should eq('event')
        parse('event_name', :event_name).should eq('event_name')
      end

      it 'raises on invalid variable names' do
        lambda{ parse('NotAnEventName',  :event_name) }.should raise_error(Citrus::ParseError)
        lambda{ parse('notAnEventName',  :event_name) }.should raise_error(Citrus::ParseError)
      end

    end # event_name

    describe 'the task_start_or_end rule' do

      it 'parses correct event names' do
        parse('Task:start', :task_start_or_end).should eq('Task:start')
        parse('Task:end',   :task_start_or_end).should eq('Task:end')
      end

      it 'raises on simple task names' do
        lambda{ parse('Task', :task_start_or_end) }.should raise_error(Citrus::ParseError)
      end

    end # task_start_or_end

    describe 'the event rule' do

      it 'parses correct events' do
        parse('Task:start', :event).should eq('Task:start')
        parse('Task:end',   :event).should eq('Task:end')
        parse('an_event',   :event).should eq('an_event')
      end

      it 'raises on invalid event names' do
        lambda{ parse('Task', :event) }.should raise_error(Citrus::ParseError)
      end

    end

  end
end