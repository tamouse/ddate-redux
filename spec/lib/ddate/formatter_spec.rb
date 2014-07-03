require 'spec_helper'

module Ddate

  describe Formatter do

    it "creates default formatter" do
      formatter = Ddate::Formatter.new
      expect(formatter.standard).to eq("%{dayname}, %{seasonname} the %{dayth}, YOLD %{year}.#{Ddate::Formatter::SPLIT_STOP} Celebrate %{holiday}!")
      expect(formatter.sttibs).to eq("%{st_tibs_day}, YOLD %{year}.#{Ddate::Formatter::SPLIT_STOP} Celebrate %{holiday}!")
    end

    it 'creates an alternative formatter' do
      format = 'Today is %{%A %B %d%}, %Y YOLD%N%nCelebrate %H!'
      formatter = Ddate::Formatter.new(format)
      expect(formatter.standard).to eq("Today is %{dayname} %{seasonname} %{day}, %{year} YOLD#{Ddate::Formatter::SPLIT_STOP}\nCelebrate %{holiday}!")
      expect(formatter.sttibs).to eq("Today is %{st_tibs_day}, %{year} YOLD#{Ddate::Formatter::SPLIT_STOP}\nCelebrate %{holiday}!")
    end

  end
end
