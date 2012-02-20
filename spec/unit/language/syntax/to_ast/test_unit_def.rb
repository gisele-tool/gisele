require 'spec_helper'
module Gisele::Language::Syntax
  describe UnitDef, 'to_ast' do

    it 'converts a single task definition as expected' do
      expr = <<-UNIT.strip
        task Task1 end
      UNIT
      expected = \
        [:unit_def, 
          [:task_def, "Task1", [:nop]]]
      ast(expr, :unit_def).should eq(expected)
    end

    it 'accepts multiple task definitions' do
      expr = <<-UNIT.strip
        task Task1 end
        task Task2 end
      UNIT
      expected = \
        [:unit_def, 
          [:task_def, "Task1", [:nop]],
          [:task_def, "Task2", [:nop]] ]
      ast(expr, :unit_def).should eq(expected)
    end

  end
end
