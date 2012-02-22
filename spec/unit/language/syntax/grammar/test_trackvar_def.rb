require 'spec_helper'
module Gisele::Language
  describe Grammar, 'trackvar_def' do

    it 'parses valid tracking variable definitions' do
      defn = 'trackvar plateletLow {BloodTest:end}'
      parse(defn, :trackvar_def).should eq(defn)
    end

    it 'supports an optional initial value' do
      defn = 'trackvar plateletLow {BloodTest:end} initially false'
      parse(defn, :trackvar_def).should eq(defn)
    end

    it 'supports optional obsolete events' do
      defn = 'trackvar plateletLow {BloodTest:end}, {Chemotherapy:end}'
      parse(defn, :trackvar_def).should eq(defn)
    end

  end
end