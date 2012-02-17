require 'spec_helper'
module Gisele
  describe Language do
    include Language

    describe "rule2mod" do

      it 'work on simple rule name' do
        rule2mod(:test).should eq(:Test)
      end

      it 'works when underscores are present' do
        rule2mod(:a_rule_name).should eq(:ARuleName)
      end

    end # rule2mod

    describe "mod2rule" do

      it 'work on simple module name' do
        mod2rule(:Test).should eq(:test)
      end

      it 'work on complex module name' do
        mod2rule(:ThisIsATest).should eq(:this_is_a_test)
      end

      it 'works with a module' do
        mod2rule(::Gisele::Language::Syntax::WhileSt).should eq(:while_st)
      end

    end # rule2mod

  end
end