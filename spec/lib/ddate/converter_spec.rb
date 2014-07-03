require 'spec_helper'

module Ddate

  describe Converter do

    [1972, 1996, 2012].each do |year|
      it "#{year} should be a leap year" do
        expect(Ddate::Converter.new(year, 1, 1).leapyear?).to eq(true)
      end
    end

    [1971, 2014, 2015, 2017].each do |year|
      it "#{year} should NOT be a leap year" do
        expect(Ddate::Converter.new(year, 1, 1).leapyear?).not_to eq(true)
      end
    end

    it "should convert 2014-01-01" do
      ddate = Ddate::Converter.new(2014, 1, 1)
      expect(ddate.year).to eq(2014+1166)
      expect(ddate.day).to eq(0)
      expect(ddate.season).to eq(0)
      expect(ddate.to_s).to eq("Sweetmorn, Chaos the 1st, YOLD #{2014+1166}.")
    end

    it "should convert 1972-07-23" do
      ddate = Ddate::Converter.new(1972, 7, 23)
      expect(ddate.year).to eq(1972+1166)
      expect(ddate.day).to eq(57)
      expect(ddate.season).to eq(2)
      expect(ddate.leapyear?).to eq(true)
      expect(ddate.to_s).to eq("Prickle-Prickle, Confusion the 58th, YOLD 3138.")
    end

    it "should convert 1993-12-31" do
      ddate = Ddate::Converter.new(1993, 12, 31)
      expect(ddate.year).to eq(1993+1166)
      expect(ddate.day).to eq(72)
      expect(ddate.season).to eq(4)
      expect(ddate.to_s).to eq("Setting Orange, The Aftermath the 73rd, YOLD 3159.")
    end

    it "should get st. tib's day right" do
      ddate = Ddate::Converter.new(2012,2,29)
      expect(ddate.year).to eq(2012+1166)
      expect(ddate.leapyear?).to eq(true)
      expect(ddate.day).to eq(:st_tibs)
      expect(ddate.season).to eq(0)
      expect(ddate.to_s).to eq("Feast of St. Tib's Day, YOLD #{2012+1166}.")
    end

    it "should get day after st. tib's day right" do
      ddate = Ddate::Converter.new(2012,3,1)
      expect(ddate.year).to eq(2012+1166)
      expect(ddate.day).to eq(59)
      expect(ddate.season).to eq(0)
      expect(ddate.to_s).to eq("Setting Orange, Chaos the 60th, YOLD 3178.")
    end

    it "should get last day of leap year right, too" do
      ddate = Ddate::Converter.new(2012, 12, 31)
      expect(ddate.year).to eq(2012+1166)
      expect(ddate.day).to eq(72)
      expect(ddate.season).to eq(4)
      expect(ddate.to_s).to eq("Setting Orange, The Aftermath the 73rd, YOLD 3178.")
    end

    it "should get season holiday right" do
      ddate = Ddate::Converter.new(1995, 9, 26)
      expect(ddate.to_s).to eq("Prickle-Prickle, Bureaucracy the 50th, YOLD 3161. Celebrate Bureflux!")
    end

    it 'should get saint day right' do
      ddate = Ddate::Converter.new(1995, 1, 5)
      expect(ddate.to_s).to eq('Setting Orange, Chaos the 5th, YOLD 3161. Celebrate Mungday!')
    end

  end

end
