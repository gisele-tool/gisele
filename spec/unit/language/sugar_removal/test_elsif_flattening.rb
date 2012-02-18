require 'spec_helper'
module Gisele::Language
  describe SugarRemoval::ElsifFlattening do
    include AST::Helpers

    def ast(source)
      Syntax.ast(source.strip, :root => :if_st)
    end

    def rewrite(ast)
      SugarRemoval::ElsifFlattening.new(SugarRemoval.new).call(ast)
    end

    it 'rewrites a single if correctly' do
      source = ast("if goodCond Task1 end")
      rewrite(source).should eq(source)
    end

    it 'rewrites a if/else correctly' do
      source = ast("if goodCond Task1 else Task2 end")
      rewrite(source).should eq(source)
    end

    it 'rewrites a if/elsif correctly' do
      source   = ast("if good Task1 elsif bad Task2 end")
      expected = ast("if good Task1 else if bad Task2 end end")
      rewrite(source).should eq(expected)
    end

    it 'rewrites a if/elsif/else correctly' do
      source   = ast("if good Task1 elsif bad Task2 else Task3 end")
      expected = ast("if good Task1 else if bad Task2 else Task3 end end")
      rewrite(source).should eq(expected)
    end

    it 'rewrites a if/elsif/elsif/else correctly' do
      source = ast(<<-EOF.strip)
        if good Task1
        elsif bad Task2
        elsif none Task3
        else Task4
        end
      EOF
      expected = ast(<<-EOF.strip)
        if good
          Task1
        else
          if bad
            Task2
          else
            if none
              Task3
            else
              Task4
            end
          end
        end
      EOF
      rewrite(source).should eq(expected)
    end

  end
end
