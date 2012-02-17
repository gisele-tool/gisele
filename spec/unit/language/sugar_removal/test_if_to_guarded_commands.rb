require 'spec_helper'
module Gisele::Language
  describe SugarRemoval do
    describe "if_st to case_st" do
      include AST::Helpers

      def rewrite(ast)
        SugarRemoval.new.call(node(ast))
      end

      it 'rewrites single if correctly' do
        source   = [:if, [:varref, "goodCond"], [:task_call, "Task1"]]
        expected = \
          [:case,
            [:when, [:varref, "goodCond"], [:task_call, "Task1"] ]]
        rewrite(source).should eq(expected)
      end

      it 'negates the else clause' do
        source   = \
          [:if,
            [:varref, "goodCond"], [:task_call, "Task1"],
            [:else,                [:task_call, "Task2"] ]]
        expected = \
          [:case,
            [:when, [:varref, "goodCond"], [:task_call, "Task1"] ],
            [:when, [:not, [:varref, "goodCond"]], [:task_call, "Task2"] ]
          ]
        rewrite(source).should eq(expected)
      end

      it 'handles elsif clauses correctly' do
        source = \
          [:if,
            [:varref, "c1"], [:task_call, "Task1"],
            [:elsif, [:varref, "c2"], [:task_call, "Task2"]],
            [:elsif, [:varref, "c3"], [:task_call, "Task3"]],
            [:else,                   [:task_call, "Task4"] ]]
        expected = \
          [:case,
            [:when,
              [:varref, "c1"],
              [:task_call, "Task1"] ],
            [:when,
              [:and,
                [:varref, "c2"],
                [:not, [:varref, "c1"]] ],
              [:task_call, "Task2"] ],
            [:when,
              [:and,
                [:varref, "c3"],
                [:and,
                  [:not, [:varref, "c2"]],
                  [:not, [:varref, "c1"]] ]],
              [:task_call, "Task3"] ],
            [:when,
              [:and,
                [:not, [:varref, "c3"]],
                [:and,
                  [:not, [:varref, "c2"]],
                  [:not, [:varref, "c1"]]]],
              [:task_call, "Task4"] ],
          ]
        rewrite(source).should eq(expected)
      end

      it 'recurse on other nodes' do
        if_st = [:if, [:varref, "goodCond"], [:task_call, "Task1"]]
        rw_st = rewrite(if_st)
        rewrite([:unit, if_st]).should eq([:unit, rw_st])
      end

    end
  end
end
