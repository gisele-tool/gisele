require 'spec_helper'
module Gisele
  module Compiling
    describe ToGlts do

      it 'returns an array of Automaton when called on a unit_def' do
        got = ToGlts.call(complete_ast)
        got.should be_a(Array)
        got.all?{|x| x.is_a? Stamina::Automaton}.should be_true
      end

      it 'returns a Digraph when called on a task_def' do
        got = ToGlts.call(complete_ast.last)
        got.should be_a(Stamina::Automaton)
        got.depth
      end

    end
  end
end