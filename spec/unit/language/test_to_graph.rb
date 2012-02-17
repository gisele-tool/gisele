require 'spec_helper'
module Gisele::Language
  describe ToGraph do

    it 'returns a Digraph' do
      ToGraph.new.call(complete_ast).should be_a(Yargi::Digraph)
    end

  end
end