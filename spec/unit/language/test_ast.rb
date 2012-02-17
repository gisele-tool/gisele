require 'spec_helper'
module Gisele::Language
  describe AST do

    describe 'ast' do

      it 'returns a node' do
        node = [:unit].extend(AST::Node)
        AST.node(node).object_id.should eq(node.object_id)
      end

      it 'coerces an array' do
        AST.node([:unit]).should eq([:unit])
        AST.node([:unit]).should be_a(AST::Unit)
      end

      it 'falls back to Node' do
        AST.node([:nosuchnode]).should eq([:nosuchnode])
        AST.node([:nosuchnode]).should be_a(AST::Node)
      end

      it 'raises unless a ast node array' do
        lambda{ AST.node("foo") }.should raise_error(ArgumentError, /foo/)
        lambda{ AST.node(nil) }.should raise_error(ArgumentError, /nil/)
        lambda{ AST.node([]) }.should raise_error(ArgumentError, /\[\]/)
        lambda{ AST.node(["foo"]) }.should raise_error(ArgumentError, /foo/)
      end

    end # .ast

  end
end