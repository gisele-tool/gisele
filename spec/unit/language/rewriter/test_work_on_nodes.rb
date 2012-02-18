require 'spec_helper'
module Gisele::Language
  class Rewriter
    describe WorkOnNodes do

      let(:won){ WorkOnNodes.new }

      it 'extends input nodes' do
        node = [:hello, "world"]
        seen = won.call(:rw, node) do |_,n|
          n.should be_a(AST::Node)
          n
        end
        seen.should eq(node)
      end

      it 'extends output nodes' do
        node = [:hello, "world"]
        seen = won.call(:rw, node) do |_,n|
          n.should be_a(AST::Node)
          [:result]
        end
        seen.should eq([:result])
        seen.should be_a(AST::Node)
      end

      it 'does not require the output to be a node' do
        node = [:hello, "world"]
        seen = won.call(:rw, node) do |_,n|
          n.should be_a(AST::Node)
          "blah"
        end
        seen.should eq("blah")
        seen.should_not be_a(AST::Node)
      end

      it 'fails unless the input looks a node' do
        lambda{
          won.call(:rw, "blah") do |_,n| end
        }.should raise_error(ArgumentError, /blah/)
      end

    end
  end
end
