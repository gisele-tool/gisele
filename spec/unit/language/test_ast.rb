require 'spec_helper'
module Gisele::Language
  describe Grammar, "ast" do

    let(:grammar){ Gisele::Language::Grammar }

    def ast(text, rule, consume = true)
      grammar.parse(text, :root => rule, :consume => consume).value
    end

    describe "the bool_expr rule" do

      it 'returns expected ast on simple expressions' do
        expected = [:and, [:varref, "diagKnown"], [:varref, "platLow"]]
        ast("diagKnown and platLow", :bool_expr).should eq(expected)
      end

      it 'respects priorities' do
        expected = [:or, [:and, [:varref, "diagKnown"], [:varref, "platLow"]], [:varref, "platHigh"]]
        ast("diagKnown and platLow or platHigh", :bool_expr).should eq(expected)
      end

      it 'supports double negations' do
        expected = [:not, [:not, [:varref, "diagKnown"]]]
        ast("not not(diagKnown)", :bool_expr).should eq(expected)
      end

    end # bool_expr

    describe 'the event_commalist rule' do

      it 'parses singleton lists as expected' do
        expr     = 'Diagnosis:start'
        expected = ["Diagnosis:start"]
        ast(expr, :event_commalist).should eq(expected)
      end

      it 'parses non empty lists as expected' do
        expr     = 'Diagnosis:start, an_event'
        expected = ["Diagnosis:start", "an_event"]
        ast(expr, :event_commalist).should eq(expected)
      end

    end # event_commalist

    describe 'the event_set rule' do

      it 'parses non empty lists as expected' do
        expr     = '{Diagnosis:start, an_event}'
        expected = [:event_set, "Diagnosis:start", "an_event"]
        ast(expr, :event_set).should eq(expected)
      end

    end # event_set

    describe "the fluent_def rule" do

      it 'parses fluent definitions as expected' do
        defn     = "fluent diagKnown {Diagnosis:start, diagnosis}, {Treatment:end} initially false"
        expected = [:fluent,
                     "diagKnown",
                     [:event_set, "Diagnosis:start", "diagnosis"],
                     [:event_set, "Treatment:end"],
                     false]
        ast(defn, :fluent_def).should eq(expected)
      end

      it 'does not require the initial value' do
        defn     = "fluent diagKnown {Diagnosis:start, diagnosis}, {Treatment:end}"
        expected = [:fluent,
                     "diagKnown",
                     [:event_set, "Diagnosis:start", "diagnosis"],
                     [:event_set, "Treatment:end"],
                     nil]
        ast(defn, :fluent_def).should eq(expected)
      end

    end # fluent_def rule

    describe "the trackvar_def rule" do

      it 'parses tracking variable definitions as expected' do
        defn     = "trackvar mplus {Diagnosis:start}"
        expected = [:trackvar,
                     "mplus",
                     [:event_set, "Diagnosis:start"],
                     [:event_set],
                     nil]
        ast(defn, :trackvar_def).should eq(expected)
      end

      it 'supports obsolete events and initial value' do
        defn     = "trackvar mplus {Diagnosis:start}, {Treatment:end} initially true"
        expected = [:trackvar,
                     "mplus",
                     [:event_set, "Diagnosis:start"],
                     [:event_set, "Treatment:end"],
                     true]
        ast(defn, :trackvar_def).should eq(expected)
      end

    end # trackvar_def rule

    describe "the task_call_statement rule" do

      it 'parses as expected' do
        ast("Diagnosis", :task_call_statement).should eq([:task_call, "Diagnosis"])
      end

    end # task_call_statement

    describe "the statement_list rule" do

      it 'parses a list of 2 elements' do
        expr     = "Task1 Task2"
        expected = [[:task_call, "Task1"], [:task_call, "Task2"]]
        ast(expr, :statement_list).should eq(expected)
      end

      it 'parses a list of 3 elements' do
        expr     = "Task1 Task2 Task3"
        expected = [[:task_call, "Task1"], [:task_call, "Task2"], [:task_call, "Task3"]]
        ast(expr, :statement_list).should eq(expected)
      end

    end # statement_list

    describe "the par_statement rule" do

      it 'parses as expected' do
        expr     = "par Task1 Task2 end"
        expected = [:par, [:task_call, "Task1"], [:task_call, "Task2"]]
        ast(expr, :par_statement).should eq(expected)
      end

    end # par_statement

    describe "the seq_statement rule" do

      it 'parses as expected' do
        expr     = "seq Task1 Task2 end"
        expected = [:seq, [:task_call, "Task1"], [:task_call, "Task2"]]
        ast(expr, :seq_statement).should eq(expected)
      end

    end # seq_statement

    describe "the while_statement rule" do

      it 'parses as expected' do
        expr     = "while goodCond Task1 end"
        expected = \
          [:while,
            [:varref, "goodCond"],
            [:task_call, "Task1"]]
        ast(expr, :while_statement).should eq(expected)
      end

      it 'recognizes implicit sequences' do
        expr     = "while goodCond Task1 Task2 end"
        expected = \
          [:while,
            [:varref, "goodCond"],
            [:seq, [:task_call, "Task1"], [:task_call, "Task2"]]]
        ast(expr, :while_statement).should eq(expected)
      end

    end # while_statement

    describe "the else_clause rule" do

      it 'parses as expected' do
        expr     = "else Task1 "
        expected = \
          [:else, [:task_call, "Task1"]]
        ast(expr, :else_clause).should eq(expected)
      end

    end # else_clause

    describe "the elsif_clause rule" do

      it 'parses as expected' do
        expr     = "elsif goodCond Task1 "
        expected = \
          [:elsif, [:varref, "goodCond"], [:task_call, "Task1"]]
        ast(expr, :elsif_clause).should eq(expected)
      end

    end # elsif_clause

    describe "the if_statement rule" do

      it 'parses as expected' do
        expr     = "if goodCond Task1 end"
        expected = \
          [:if, [:varref, "goodCond"], [:task_call, "Task1"]]
        ast(expr, :if_statement).should eq(expected)
      end

      it 'supports a else clause' do
        expr     = "if goodCond Task1 else Task2 end"
        expected = \
          [:if,
            [:varref, "goodCond"], [:task_call, "Task1"],
            [:else, [:task_call, "Task2"]] ]
        ast(expr, :if_statement).should eq(expected)
      end

      it 'supports elsif clauses' do
        expr     = "if goodCond Task1 elsif otherCond Task2 elsif stillAnother Task3 else Task4 end"
        expected = \
          [:if,
            [:varref, "goodCond"], [:task_call, "Task1"],
            [:elsif,
              [:varref, "otherCond"], [:task_call, "Task2"]],
            [:elsif,
              [:varref, "stillAnother"], [:task_call, "Task3"]],
            [:else,
              [:task_call, "Task4"]] ]
        ast(expr, :if_statement).should eq(expected)
      end

    end # if_statement

  end
end