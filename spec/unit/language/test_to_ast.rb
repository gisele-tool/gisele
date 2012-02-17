require 'spec_helper'
module Gisele::Language
  describe Grammar, "ast" do

    let(:grammar){ Gisele::Language::Grammar }

    def ast(text, rule, consume = true)
      grammar.parse(text, :root => rule, :consume => consume).to_ast
    end

    describe "the bool_expr rule" do

      it 'returns expected ast on simple expressions' do
        expected = [:bool_and, [:var_ref, "diagKnown"], [:var_ref, "platLow"]]
        ast("diagKnown and platLow", :bool_expr).should eq(expected)
      end

      it 'respects priorities' do
        expected = [:bool_or, [:bool_and, [:var_ref, "diagKnown"], [:var_ref, "platLow"]], [:var_ref, "platHigh"]]
        ast("diagKnown and platLow or platHigh", :bool_expr).should eq(expected)
      end

      it 'supports double negations' do
        expected = [:bool_not, [:bool_not, [:var_ref, "diagKnown"]]]
        ast("not not(diagKnown)", :bool_expr).should eq(expected)
      end

    end # bool_expr

    describe 'the event_set rule' do

      it 'parses empty lists as expected' do
        expr     = '{ }'
        expected = [:event_set]
        ast(expr, :event_set).should eq(expected)
      end

      it 'parses singleton lists as expected' do
        expr     = '{Diagnosis:start}'
        expected = [:event_set, "Diagnosis:start"]
        ast(expr, :event_set).should eq(expected)
      end

      it 'parses non empty lists as expected' do
        expr     = '{Diagnosis:start, an_event, another_one}'
        expected = [:event_set, "Diagnosis:start", "an_event", "another_one"]
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

    describe "the task_call_st rule" do

      it 'parses as expected' do
        ast("Diagnosis", :task_call_st).should eq([:task_call_st, "Diagnosis"])
      end

    end # task_call_statement

    describe "the st_list rule" do

      it 'parses a list of 2 elements' do
        expr     = "Task1 Task2"
        expected = [[:task_call_st, "Task1"], [:task_call_st, "Task2"]]
        ast(expr, :st_list).should eq(expected)
      end

      it 'parses a list of 3 elements' do
        expr     = "Task1 Task2 Task3"
        expected = [[:task_call_st, "Task1"], [:task_call_st, "Task2"], [:task_call_st, "Task3"]]
        ast(expr, :st_list).should eq(expected)
      end

    end # st_list

    describe "the par_st rule" do

      it 'parses as expected' do
        expr     = "par Task1 Task2 end"
        expected = [:par_st, [:task_call_st, "Task1"], [:task_call_st, "Task2"]]
        ast(expr, :par_st).should eq(expected)
      end

    end # par_st

    describe "the seq_st rule" do

      it 'parses as expected' do
        expr     = "seq Task1 Task2 end"
        expected = [:seq_st, [:task_call_st, "Task1"], [:task_call_st, "Task2"]]
        ast(expr, :seq_st).should eq(expected)
      end

    end # seq_st

    describe "the while_statement rule" do

      it 'parses as expected' do
        expr     = "while goodCond Task1 end"
        expected = \
          [:while_st,
            [:var_ref, "goodCond"],
            [:task_call_st, "Task1"]]
        ast(expr, :while_st).should eq(expected)
      end

      it 'recognizes implicit sequences' do
        expr     = "while goodCond Task1 Task2 end"
        expected = \
          [:while_st,
            [:var_ref, "goodCond"],
            [:seq_st, [:task_call_st, "Task1"], [:task_call_st, "Task2"]]]
        ast(expr, :while_st).should eq(expected)
      end

    end # while_statement

    describe "the else_clause rule" do

      it 'parses as expected' do
        expr     = "else Task1 "
        expected = \
          [:else_clause, [:task_call_st, "Task1"]]
        ast(expr, :else_clause).should eq(expected)
      end

    end # else_clause

    describe "the elsif_clause rule" do

      it 'parses as expected' do
        expr     = "elsif goodCond Task1 "
        expected = \
          [:elsif_clause, [:var_ref, "goodCond"], [:task_call_st, "Task1"]]
        ast(expr, :elsif_clause).should eq(expected)
      end

    end # elsif_clause

    describe "the if_statement rule" do

      it 'parses as expected' do
        expr     = "if goodCond Task1 end"
        expected = \
          [:if_st, [:var_ref, "goodCond"], [:task_call_st, "Task1"]]
        ast(expr, :if_st).should eq(expected)
      end

      it 'supports a else clause' do
        expr     = "if goodCond Task1 else Task2 end"
        expected = \
          [:if_st,
            [:var_ref, "goodCond"], [:task_call_st, "Task1"],
            [:else_clause, [:task_call_st, "Task2"]] ]
        ast(expr, :if_st).should eq(expected)
      end

      it 'supports elsif clauses' do
        expr     = "if goodCond Task1 elsif otherCond Task2 elsif stillAnother Task3 else Task4 end"
        expected = \
          [:if_st,
            [:var_ref, "goodCond"], [:task_call_st, "Task1"],
            [:elsif_clause,
              [:var_ref, "otherCond"], [:task_call_st, "Task2"]],
            [:elsif_clause,
              [:var_ref, "stillAnother"], [:task_call_st, "Task3"]],
            [:else_clause,
              [:task_call_st, "Task4"]] ]
        ast(expr, :if_st).should eq(expected)
      end

    end # if_statement

    describe 'the task_refinement rule' do

      it 'parses as expected' do
        expr     = "refinement Task1 end"
        expected = [:task_refinement, [:task_call_st, "Task1"]]
        ast(expr, :task_refinement).should eq(expected)
      end

    end # task_refinement

    describe 'the task_signature rule' do

      it 'parses as expected' do
        expr     = "fluent diagKnown {}, {}\ntrackvar mplus {}"
        expected = \
          [ :task_signature,
            [:fluent, "diagKnown", [:event_set], [:event_set], nil],
            [:trackvar, "mplus", [:event_set], [:event_set], nil]]
        ast(expr, :task_signature).should eq(expected)
      end

    end # task_signature

    describe 'the task_def rule' do

      it 'parses as expected' do
        expr     = "task Task1 fluent diagKnown {}, {} refinement Task2 end end"
        expected = \
          [:task_def, "Task1",
            [:task_signature,
              [:fluent, "diagKnown", [:event_set], [:event_set], nil]],
            [:task_refinement,
              [:task_call_st, "Task2"]]]
        ast(expr, :task_def).should eq(expected)
      end

    end # task_def

  end
end