require 'spec_helper'

describe Ddate do

  [1970, 2014].each do |year|
    it "#{year} should be a leap year" do
      expect(Ddate.new(year, 1, 1).leapyear?).to eq(true)
    end
  end

  [1971, 2015, 2016, 2017].each do |year|
    it "#{year} should NOT be a leap year" do
      expect(Ddate.new(year, 1, 1).leapyear?).not_to eq(true)
    end
  end

  it "should convert 2014-01-01" do
    ddate = Ddate.new(2014, 1, 1)
    expect(ddate.year).to eq(2014+1166)
    expect(ddate.day).to eq(0)
    expect(ddate.season).to eq(0)
    expect(ddate.to_s).to eq("Sweetmorn, Chaos, 1st, #{2014+1166} YOLD")
  end

  it "should convert 1970-07-23" do
    ddate = Ddate.new(1970, 7, 23)
    expect(ddate.year).to eq(1970+1166)
    expect(ddate.day).to eq(56) # cos it's a leapyear
    expect(ddate.season).to eq(2)
  end

  it "should convert 1993-12-31" do
    ddate = Ddate.new(1993, 12, 31)
    expect(ddate.year).to eq(1993+1166)
    expect(ddate.day).to eq(72)
    expect(ddate.season).to eq(4)
  end

  it "should get st. tib's day right" do
    ddate = Ddate.new(2014,3,1)
    expect(ddate.year).to eq(2014+1166)
    expect(ddate.leapyear?).to eq(true)
    expect(ddate.day).to eq(:st_tibs)
    expect(ddate.season).to eq(0)
    expect(ddate.to_s).to eq("Feast of St. Tib's, #{2014+1166} YOLD")
  end

  it "should get day after st. tib's day right" do
    ddate = Ddate.new(2014,3,2)
    expect(ddate.year).to eq(2014+1166)
    expect(ddate.day).to eq(59)
    expect(ddate.season).to eq(0)
  end

  it "should get last day of leap year right, too" do
    ddate = Ddate.new(2014, 12, 31)
    STDERR.puts ddate.inspect
    expect(ddate.year).to eq(2014+1166)
    expect(ddate.day).to eq(71)
    expect(ddate.season).to eq(4)
  end

  it "should get season holiday right" do
    ddate = Ddate.new(1995, 9, 26)
    expect(ddate.to_s).to eq("Bureflux, Setting Orange, Bureaucracy, 50th, 3161 YOLD")
  end
end
