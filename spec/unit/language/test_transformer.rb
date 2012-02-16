require 'spec_helper'
module Gisele::Language
  describe Transformer do

    let(:transformer_class){
      Class.new(Transformer) do

        def on_hello(args)
          [:seen_hello] + args
        end

        def on_missing(kind, *args)
          [:seen_missing, kind] + args
        end

      end
    }

    let(:transformer){ transformer_class.new }

    it 'dispatches to existing methods' do
      ast = [:hello, "world"]
      transformer.call(ast).should eq([:seen_hello, "world"])
    end

    it 'calls on_missing when not found' do
      ast = [:nosuchone, "world"]
      transformer.call(ast).should eq([:seen_missing, :nosuchone, ["world"]])
    end

  end
end