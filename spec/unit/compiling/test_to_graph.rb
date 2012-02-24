require 'spec_helper'
module Gisele
  module Compiling
    describe ToGraph do

      it 'returns an array of Digraphs when called on a unit_def' do
        got = ToGraph.call(complete_ast)
        got.should be_a(Array)
        got.all?{|x| x.is_a? Yargi::Digraph}.should be_true
      end

      it 'returns a Digraph when called on a task_def' do
        got = ToGraph.call(complete_ast.last)
        got.should be_a(Yargi::Digraph)
      end

    end
  end
end