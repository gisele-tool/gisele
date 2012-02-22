require 'spec_helper'
module Gisele::Language
  describe Grammar, 'case_st' do

    it 'supports a single when clause' do
      expr = <<-CASE_ST.strip
        case
        when goodCond
          Task1
        end
      CASE_ST
      parse(expr, :case_st).should eq(expr)
    end

    it 'supports boolean expressions in when clauses' do
      expr = <<-CASE_ST.strip
        case
        when not(goodCond) or badCond
          Task1
        end
      CASE_ST
      parse(expr, :case_st).should eq(expr)
    end

    it 'supports a multiple when clauses' do
      expr = <<-CASE_ST.strip
        case
        when goodCond
          Task1
        when badCond
          Task2
        end
      CASE_ST
      parse(expr, :case_st).should eq(expr)
    end

    it 'supports an else clause' do
      expr = <<-CASE_ST.strip
        case
        when goodCond
          Task1
        else
          Task2
        end
      CASE_ST
      parse(expr, :case_st).should eq(expr)
    end

    it 'supports an optional variable name' do
      expr = <<-CASE_ST.strip
        case someVariable
        when goodCond
          Task1
        end
      CASE_ST
      parse(expr, :case_st).should eq(expr)
    end

  end
end