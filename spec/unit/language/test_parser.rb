require 'spec_helper'
module Gisele::Language
  describe Parser do

    fixture_files('tasks/**/*.gis').each do |file|
      if file.sub_ext(".ast").exist?

        it "returns the expected ast on #{file}" do
          parsed   = Parser.parse(file)
          expected = Kernel::eval(file.sub_ext(".ast").read, TOPLEVEL_BINDING, file.sub_ext(".ast").to_s)
          parsed.should eq(expected)
        end

      else

        it "parses #{file} without error" do
          parsed = Parser.parse(file)
          parsed.should be_a(Array)
          parsed.first.should eq(:task)
        end

      end

    end

  end
end