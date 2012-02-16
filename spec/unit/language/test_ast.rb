require 'spec_helper'
module Gisele::Language
  describe Grammar, "ast" do

    let(:grammar){ Gisele::Language::Grammar }

    def ast(text, rule, consume = true)
      grammar.parse(text, :root => rule, :consume => consume).value
    end

    describe "the bool_expr rule" do

      it 'returns expected ast on simple expressions' do
        expected = [:and, [:varref, "diagKnown"], [:varref, "platLow"]]
        ast("diagKnown and platLow", :bool_expr).should eq(expected)
      end

      it 'respect priorities' do
        expected = [:or, [:and, [:varref, "diagKnown"], [:varref, "platLow"]], [:varref, "platHigh"]]
        ast("diagKnown and platLow or platHigh", :bool_expr).should eq(expected)
      end

      it 'supports double negations' do
        expected = [:not, [:not, [:varref, "diagKnown"]]]
        ast("not not(diagKnown)", :bool_expr).should eq(expected)
      end

    end

  end
end