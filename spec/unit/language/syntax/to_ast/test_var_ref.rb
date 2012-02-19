require 'spec_helper'
module Gisele::Language::Syntax
  describe VarRef, "to_ast" do

    it 'converts a reference as expected' do
      defn     = "goodCond"
      expected = [:var_ref, "goodCond"]
      ast(defn, :var_ref).should eq(expected)
    end

  end
end
