require 'spec_helper'
module Gisele::Language::Syntax
  describe Unit, 'to_ast' do

    it 'converts a single task definition as expected' do
      expr = <<-UNIT.strip
        task Task1 end
      UNIT
      expected = \
        [:unit, 
          [:task_def, "Task1", [:nop]]]
      ast(expr, :unit).should eq(expected)
    end

    it 'accepts multiple task definitions' do
      expr = <<-UNIT.strip
        task Task1 end
        task Task2 end
      UNIT
      expected = \
        [:unit, 
          [:task_def, "Task1", [:nop]],
          [:task_def, "Task2", [:nop]] ]
      ast(expr, :unit).should eq(expected)
    end

  end
end
