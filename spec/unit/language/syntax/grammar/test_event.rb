require 'spec_helper'
module Gisele::Language::Syntax
  describe Grammar, 'event' do

    it 'parses correct events' do
      parse('Task:start', :event).should eq('Task:start')
      parse('Task:end',   :event).should eq('Task:end')
      parse('an_event',   :event).should eq('an_event')
    end

    it 'raises on invalid event names' do
      lambda{
        parse('Task', :event)
      }.should raise_error(Citrus::ParseError)
    end

  end
end
