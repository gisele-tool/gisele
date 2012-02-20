require 'spec_helper'
module Gisele::Language::Syntax
  describe Grammar, 'unit' do

    it 'parses a single task definition' do
      expr = <<-UNIT.strip
        task Task1 end
      UNIT
      parse(expr, :unit).should eq(expr)
    end

    it 'accepts multiple task definitions' do
      expr = <<-UNIT.strip
        task Task1 end
        task Task2 end
      UNIT
      parse(expr, :unit).should eq(expr)
    end

    it 'allows trailing spaces' do
      expr = <<-UNIT
        task Task1 end
        task Task2 end
      UNIT
      parse(expr, :unit).should eq(expr)
    end

  end
end
