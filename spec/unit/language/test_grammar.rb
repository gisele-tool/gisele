require 'spec_helper'
module Gisele::Language
  describe Grammar do

    let(:grammar){ Gisele::Language::Grammar }

    def parse(text, rule, consume = true)
      grammar.parse(text, :root => rule, :consume => consume)
    end

    ### Spacing

    describe 'the spaces rule' do

      it 'parses all kind of spaces' do
        parse(' ', :spaces).should eq(' ')
        parse("\t", :spaces).should eq("\t")
        parse("\n", :spaces).should eq("\n")
        parse(" \t\n", :spaces).should eq(" \t\n")
      end

      it 'enforces mandatory spacing' do
        lambda{ parse('', :spaces) }.should raise_error(Citrus::ParseError)
      end

    end

    describe 'the spacing rule' do

      it 'parses all kind of spaces' do
        parse(' ', :spacing).should eq(' ')
        parse("\t", :spacing).should eq("\t")
        parse("\n", :spacing).should eq("\n")
        parse(" \t\n", :spacing).should eq(" \t\n")
      end

      it 'does not enforces mandatory spacing' do
        parse('', :spacing).should eq('')
      end

    end

    ### Literals

    describe 'the boolean_literal rule' do

      it 'parses booleans' do
        parse('true',  :boolean_literal).should eq('true')
        parse('false', :boolean_literal).should eq('false')
      end

      it 'does not parses integers' do
        lambda{ parse('0', :boolean_literal) }.should raise_error(Citrus::ParseError)
      end

    end

    ### Names

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

    ### Events

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

    end # event

    describe 'the event_commalist rule' do

      it 'parses a singleton list' do
        parse('Task:start', :event_commalist).should eq('Task:start')
      end

      it 'parses multiple events' do
        parse('Task:start, an_event', :event_commalist).should eq('Task:start, an_event')
      end

      it 'recognizes invalid events' do
        lambda{ parse('Task:start, NotAnEvent', :event_commalist) }.should raise_error(Citrus::ParseError)
      end

    end # event_commalist

    describe 'the event_set rule' do

      it 'parses empty sets' do
        parse('{}', :event_set).should eq('{}')
        parse('{   }', :event_set).should eq('{   }')
      end

      it 'parses event singletons' do
        parse('{Task:start}', :event_set).should eq('{Task:start}')
        parse('{  Task:start  }', :event_set).should eq('{  Task:start  }')
      end

      it 'recognizes invalid events in the set' do
        lambda{ parse('{Task:start, NotAnEvent}', :event_set) }.should raise_error(Citrus::ParseError)
      end

    end # event_set

    ### Variables


    describe 'the fluent_def rule' do

      it 'parses valid fluent definitions' do
        defn = 'fluent diagKnown {Diagnosis:start}, {Treatment:end} initially false'
        parse(defn, :fluent_def).should eq(defn)
      end

      it 'supports a missing initial value' do
        defn = 'fluent diagKnown {Diagnosis:start}, {Treatment:end}'
        parse(defn, :fluent_def).should eq(defn)
      end

      it 'supports empty sets for events' do
        defn = 'fluent diagKnown {}, {} initially true'
        parse(defn, :fluent_def).should eq(defn)
      end

    end # fluent_def

  end
end