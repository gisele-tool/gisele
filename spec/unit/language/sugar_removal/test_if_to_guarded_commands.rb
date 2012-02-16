require 'spec_helper'
module Gisele::Language
  describe SugarRemoval do
    describe "IfToGuardedCommands" do

      def rewrite(ast)
        SugarRemoval.new.call(ast)
      end

      it 'rewrites single if correctly' do
        source   = [:if, [:varref, "goodCond"], [:task_call, "Task1"]]
        expected = \
          [:case,
            [:when, [:varref, "goodCond"], [:task_call, "Task1"] ]]
        rewrite(source).should eq(expected)
      end

    end
  end
end