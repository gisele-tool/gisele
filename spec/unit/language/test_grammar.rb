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

  end
end