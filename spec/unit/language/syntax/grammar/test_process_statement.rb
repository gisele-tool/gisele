require 'spec_helper'
module Gisele::Language
  describe Grammar, 'process_statement' do

    it 'parses a simple process statement' do
      expr = <<-PROCESS.strip
        DoSomething
        if goodCond
          DoForGood
        else
          DoForBad
        end
        CleanDesk
      PROCESS
      parse(expr, :process_statement).should eq(expr)
    end

  end
end
