require 'spec_helper'
module Gisele::Language
  describe Grammar, 'event_name' do

    it 'parses correct event names' do
      parse('a',          :event_name).should eq('a')
      parse('event',      :event_name).should eq('event')
      parse('event_name', :event_name).should eq('event_name')
    end

    it 'raises on invalid variable names' do
      lambda{
        parse('NotAnEventName',  :event_name)
      }.should raise_error(Citrus::ParseError)
      lambda{
        parse('notAnEventName',  :event_name)
      }.should raise_error(Citrus::ParseError)
    end

  end
end