require 'spec_helper'
module Gisele::Language
  describe Rewriter do

    let(:rewriter_class){
      Class.new(Rewriter) do

        def on_hello(node)
          [:seen_hello, node]
        end

        def on_copy(node)
          copy_and_applyall(node)
        end

        def on_missing(node)
          if node.rule_name == :nosuchone
            [:seen_missing, node]
          else
            super
          end
        end

      end
    }
    let(:rewriter){ rewriter_class.new }

    describe 'mainflow' do

      it 'defaults to self' do
        rewriter.mainflow.should eq(rewriter)
      end

      it 'may be passed through options' do
        rw = rewriter_class.new(:mainflow => :hello)
        rw.mainflow.should eq(:hello)
      end

    end # mainflow

    describe 'call' do

      it 'dispatches to existing methods' do
        ast = [:hello, "world"]
        rewriter.call(ast).should eq([:seen_hello, [:hello, "world"]])
      end

      it 'calls on_missing when not found' do
        ast = [:nosuchone, "world"]
        rewriter.call(ast).should eq([:seen_missing, [:nosuchone, "world"]])
      end

      it 'raises unexpected by default in on_missing' do
        ast = [:nonono, "world"]
        lambda{ rewriter.call(ast) }.should raise_error(Gisele::UnexpectedNodeError, /nonono/)
      end

      it 'performs post node transformation if required' do
        ast = [:hello, "world"]
        rewriter.call(ast).should be_a(AST::Node)
      end

      it 'raises an ArgumentError unless called on a non terminal' do
        lambda{
          rewriter.call("world").should raise_error(ArgumentError, /world/)
        }
      end

    end

    describe "copy_and_applyall" do

      it 'provides a friendly way of applying copy/recurse' do
        ast = [:copy, [:hello, 'world'], "!"]
        rewriter.call(ast).should eq([:copy, [:seen_hello, [:hello, "world"]], "!"])
      end

    end

  end
end
