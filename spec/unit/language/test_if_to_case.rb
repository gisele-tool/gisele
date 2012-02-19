require 'spec_helper'
module Gisele::Language
  describe IfToCase do

    def ast(source)
      Syntax.ast(source.strip, :root => :if_st)
    end

    def rewrite(ast)
      IfToCase.new.call(ast)
    end

    it 'rewrites single if correctly' do
      source   = ast("if goodCond Task1 end")
      expected = \
        [:case_st, nil,
          [:when_clause,
            [:bool_expr, [:var_ref, "goodCond"]],
            [:task_call_st, "Task1"] ]]
      rewrite(source).should eq(expected)
    end

    it 'negates the else clause' do
      source   = ast("if goodCond Task1 else Task2 end")
      expected = \
        [:case_st, nil,
          [:when_clause,
            [:bool_expr, [:var_ref, "goodCond"]],
            [:task_call_st, "Task1"] ],
          [:when_clause,
            [:bool_expr, [:bool_not, [:var_ref, "goodCond"]]],
            [:task_call_st, "Task2"] ]
        ]
      rewrite(source).should eq(expected)
    end

    it 'handles elsif clauses correctly' do
      source = ast(<<-IF)
        if    c1 Task1
        elsif c2 Task2
        elsif c3 Task3
        else  Task4
        end
      IF
      expected = \
        [:case_st, nil,
          [:when_clause,
            [:bool_expr, [:var_ref, "c1"]],
            [:task_call_st, "Task1"] ],
          [:when_clause,
            [:bool_expr, [:bool_and,
              [:var_ref, "c2"],
              [:bool_not, [:var_ref, "c1"]] ]],
            [:task_call_st, "Task2"] ],
          [:when_clause,
            [:bool_expr, [:bool_and,
              [:var_ref, "c3"],
              [:bool_and,
                [:bool_not, [:var_ref, "c2"]],
                [:bool_not, [:var_ref, "c1"]] ]]],
            [:task_call_st, "Task3"] ],
          [:when_clause,
            [:bool_expr, [:bool_and,
              [:bool_not, [:var_ref, "c3"]],
              [:bool_and,
                [:bool_not, [:var_ref, "c2"]],
                [:bool_not, [:var_ref, "c1"]]]]],
            [:task_call_st, "Task4"] ],
        ]
      rewrite(source).should eq(expected)
    end

    it 'avoids double negations' do
      source   = ast("if not(goodCond) Task1 else Task2 end")
      expected = \
        [:case_st, nil,
          [:when_clause,
            [:bool_expr, [:bool_not, [:var_ref, "goodCond"]]],
            [:task_call_st, "Task1"] ],
          [:when_clause,
            [:bool_expr, [:var_ref, "goodCond"]],
            [:task_call_st, "Task2"] ] ]
      rewrite(source).should eq(expected)
    end

    it 'recurse on other nodes' do
      if_st = ast("if goodCond Task1 end")
      rw_st = rewrite(if_st)
      rewrite([:unit, if_st]).should eq([:unit, rw_st])
    end

    it 'keeps traceability markers on a single if' do
      if_st = ast("if goodCond Task1 end")
      rw_st = rewrite(if_st)
      rw_st.markers.should eq(if_st.markers)
      rw_st.last.markers.should eq(if_st.markers)
    end

    it 'keeps traceability markers when a else if present' do
      if_st = ast("if goodCond Task1 else Task2 end")
      rw_st = rewrite(if_st)
      rw_st.markers.should eq(if_st.markers)
      rw_st.last.markers.should eq(if_st.last.markers)
    end

  end
end
