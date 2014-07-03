module Ddate
  class Converter

    attr_accessor :formatter
    attr_reader :year, :yday, :day, :season

    private
    attr_accessor :date
    attr_writer :year, :yday, :day, :season

    public

    def initialize(year, month, day, formatter = nil)
      self.date = Date.new(year, month, day)
      self.formatter = formatter || Ddate::Formatter.new
      convert
    end

    def convert
      self.yday = date.yday - 1

      self.year = DY(date.year)
      self.day = yday

      if leapyear?
        if day == 59
          self.day = :st_tibs
        elsif day > 59
          self.day = day - 1
        end
        self.yday = day
      end

      self.season = 0
      unless day == :st_tibs
        while (day >= DAYS_PER_SEASON) do
          self.season = season + 1
          self.day = day - DAYS_PER_SEASON
        end
      end

      self
    end

    def to_s
      if st_tibs?
        dayactual = nil
        dayordinal = nil
        format = :sttibs
      else
        dayactual = day+1
        dayordinal = dayactual.ordinalize
        format = :standard
      end

      formatted = formatter[format].split(Ddate::SPLIT_STOP, 2).map do |part|
        part % {year: year, day: dayactual, dayth: dayordinal, seasonname: seasonname,
                holiday: holiday, exclaim: exclaim, kill_bob: kill_bob }
      end

      if holiday.nil? && formatted.count > 1
        formatted.pop
      end

      formatted.compact.join(", ")
    end

    def leapyear?
      (year % 4) == 0
    end

    def weekday
      day % 5
    end

    def dayname
      DAYS_LONG[weekday] unless st_tibs?
    end

    def seasonname
      SEASONS_LONG[season]
    end

    def st_tibs?
      day == :st_tibs
    end

    def holiday
      if day == 4
        APOSTLE_HOLIDAYS[season]
      elsif day == 49
        SEASON_HOLIDAYS[season]
      end
    end

    private

    def DY(year)
      year + YOLD_OFFSET
    end

  end
end
