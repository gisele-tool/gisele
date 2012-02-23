require 'spec_helper'
module Gisele::Language
  describe ScopingHelper do

    let(:rw_class) do
      Class.new(Sexpr::Rewriter) do
        grammar Gisele::Language
        helper ScopingHelper

        def on_hello(node)
          scope_stack.dup
        end

        def on_missing(node)
          call(node.sexpr_body.last)
        end

      end
    end
    let(:rw){ rw_class.new }

    it 'installs the methods on the rewriter' do
      rw.respond_to?(:scope_stack).should be_true
    end

    it 'does nothing special on non _def nodes' do
      node = [:hello, "world"]
      rw.call(node).should eq([])
    end

    it 'keeps _def nodes as successive scopes' do
      second = [:task_def, [:hello]]
      first  = [:task_def, second]
      rw.call(first).should eq([first, second])
    end

    it 'pops scopes when returning along the stack' do
      second = [:task_def, [:hello]]
      first  = [:task_def, second]
      rw.call(first)
      rw.scope_stack.should eq([])
    end

  end
end