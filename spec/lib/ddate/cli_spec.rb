require 'spec_helper'

module Ddate

  describe CLI do

    before(:all) do
      DateStruct = Struct.new :year, :month, :day
    end

    let(:ddate_runner) {Ddate::CLI.new}

    it 'reports today with no arguments' do
      year, month, day = 2014, 7, 28
      today = DateStruct.new year, month, day
      allow(Date).to receive(:today).and_return(today)
      args = []
      expect(ddate_runner.run(args)).to eq("Pungenday, Confusion the 63rd, YOLD 3180.")
    end

    it 'gives usage' do
      expect(ddate_runner.run(['-h'])).to eq(Ddate::USAGE)
    end

    it 'gives format usage' do
      expect(ddate_runner.run(['-f'])).to eq(Ddate::FORMATTER_USAGE)
    end

    it 'gives version string' do
      expect(ddate_runner.run(['-v'])).to eq(Ddate::VERSION_STRING)
    end

    it 'gives today in another format' do
      format = '+%{%a %b %d%} %Y'
      today = DateStruct.new 2014, 7, 28
      expected = 'PD Cfn 63 3180'
      allow(Date).to receive(:today).and_return(today)
      expect(ddate_runner.run([format])).to eq(expected)
    end

    it 'prints st tibs' do
      expected = "Feast of St. Tib's Day, YOLD 3162."
      expect(ddate_runner.run([1996, 2, 29])).to eq(expected)
    end

    it 'handles format and date' do
      format = '+%{%a %b %d%} %Y'
      expected = 'PD Cfn 63 3180'
      year, month, day = 2014, 7, 28
      args = [format, year, month, day]
      expect(ddate_runner.run(args)).to eq(expected)
    end

    it 'should print st tibs day in an alternate format' do
      format =  "+Today's %{%A, the %e of %B%}, %Y.%N%nCelebrate %H"
      expected = "Today's Feast of St. Tib's Day, 3162."
      args = [format, 1996, 2, 29]
      expect(ddate_runner.run(args)).to eq(expected)
    end

    it 'should show the count down until kill bob day' do
      expect(ddate_runner.run(['+%X', 8661, 6, 4])).to eq('1')
    end

    it 'should make an exclamation' do
      result = ddate_runner.run(['+%.', 8661, 6, 4])
      exclamations = Ddate::Converter::EXCLAMATIONS +
        Ddate::Converter::LINUX_EXCLAMATIONS +
        Ddate::Converter::NON_LINUX_EXCLAMATIONS
      expect(exclamations).to include(result)
    end



    describe 'error paths' do
      let(:dr) {Ddate::CLI.new}
      it 'should raise an error with invalid option' do
        expect{dr.run([-x])}.to raise_error
      end
      it 'should raise an error with an empty argument' do
        expect{dr.run([''])}.to raise_error
      end
      it 'should raise an error with 2 arguments' do
        expect{dr.run([1, 2])}.to raise_error
      end
      it 'should raise an error with 4 arguments but no format' do
        expect{dr.run([1, 2, 3, 4])}.to raise_error
      end
    end

  end

end
