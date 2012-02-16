require 'spec_helper'
module Gisele::Language
  describe Grammar do

    let(:grammar){ Gisele::Language::Grammar }

    def parse(text, rule, consume = true)
      grammar.parse(text, :root => rule, :consume => consume)
    end

    describe 'the task_name rule' do

      it 'parses correct task names' do
        parse('A',         :task_name).should eq('A')
        parse('Diagnosis', :task_name).should eq('Diagnosis')
        parse('TaskName',  :task_name).should eq('TaskName')
      end

    end

  end
end