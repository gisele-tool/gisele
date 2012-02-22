require 'spec_helper'
module Gisele::Language
  describe Grammar, 'task_def' do

    it 'parses a simple implicit task definition' do
      taskdef = <<-TASKDEF.strip
        task Process
          Diagnosis
        end
      TASKDEF
      parse(taskdef, :task_def).should eq(taskdef)
    end

    it 'allows any statement' do
      taskdef = <<-TASKDEF.strip
        task Process
          while true Diagnosis end
        end
      TASKDEF
      parse(taskdef, :task_def).should eq(taskdef)
    end

    it 'supports optional variable definitions in the signature' do
      taskdef = <<-TASKDEF.strip
        task Process
          fluent   diagKnown {Diagnosis:start}, {} initially false
          trackvar mplus     {Diagnosis:end}
          Diagnosis
        end
      TASKDEF
      parse(taskdef, :task_def).should eq(taskdef)
    end

  end
end