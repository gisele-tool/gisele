require 'spec_helper'
module Gisele::Language::Syntax
  describe Grammar, 'event_set' do

    it 'parses empty sets' do
      parse('{}', :event_set).should eq('{}')
      parse('{   }', :event_set).should eq('{   }')
    end

    it 'parses event singletons' do
      parse('{Task:start}', :event_set).should eq('{Task:start}')
      parse('{  Task:start  }', :event_set).should eq('{  Task:start  }')
    end

    it 'parses event sets' do
      parse('{Task:start, Task:end}', :event_set).should eq('{Task:start, Task:end}')
    end

    it 'recognizes invalid events in the set' do
      lambda{
        parse('{Task:start, NotAnEvent}', :event_set)
      }.should raise_error(Citrus::ParseError)
    end

  end
end

