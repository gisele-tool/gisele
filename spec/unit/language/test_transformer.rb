require 'spec_helper'
module Gisele::Language
  describe Transformer do

    let(:transformer_class){
      Class.new(Transformer) do
        public :non_terminal?

        def on_hello(*args)
          [:seen_hello] + args
        end

        def on_copy(*args)
          deep_copy(:copy, args)
        end

        def on_missing(kind, *args)
          [:seen_missing, kind] + args
        end

      end
    }

    let(:transformer){ transformer_class.new }

    describe "non_terminal?" do

      it 'recognizes non terminals' do
        transformer.non_terminal?([:hello]).should be_true
        transformer.non_terminal?([:hello, "world"]).should be_true
      end

      it 'recognizes terminals' do
        transformer.non_terminal?("world").should be_false
      end

      it 'do not fail on nil and empty arrays' do
        transformer.non_terminal?(nil).should be_false
        transformer.non_terminal?([]).should be_false
      end

    end

    describe 'call' do

      it 'dispatches to existing methods' do
        ast = [:hello, "world"]
        transformer.call(ast).should eq([:seen_hello, "world"])
      end

      it 'calls on_missing when not found' do
        ast = [:nosuchone, "world"]
        transformer.call(ast).should eq([:seen_missing, :nosuchone, ["world"]])
      end

      it 'raises an ArgumentError unless called on a non terminal' do
        lambda{
          transformer.call("world").should raise_error(ArgumentError, /world/)
        }
      end

    end

    describe "deep_copy" do

      it 'provides a friendly way of applying copy/recurse' do
        ast = [:copy, [:hello, 'world'], "!"]
        transformer.call(ast).should eq([:copy, [:seen_hello, "world"], "!"])
      end

    end

  end
end