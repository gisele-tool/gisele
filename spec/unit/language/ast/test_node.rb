require 'spec_helper'
module Gisele::Language::AST
  describe Node do

    def node(array)
      array.extend(Node)
    end

    describe 'rule_name' do
      it 'returns the first array element' do
        node([:hello]).rule_name.should eq(:hello)
      end
    end

    describe 'children' do

      it 'returns all but the rule name' do
        node([:hello, "world", "!"]).children.should eq(["world", "!"])
      end

      it 'returns an empty array when no children' do
        node([:hello]).children.should eq([])
      end

    end # children

    describe 'dup' do

      it 'duplicates the underlying array' do
        arr = [:unit, "etc."]
        node(arr).dup.should eq(arr)
      end

      it 'ensures duplicated array is still a node' do
        arr = [:unit, "etc."]
        node(arr).dup.should be_a(Unit)
        node(arr).dup.should be_a(Node)
      end

    end # dup

  end
end