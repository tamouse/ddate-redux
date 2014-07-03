module Ddate
  class Converter

    YOLD_BASE = 1970
    YOLD_OFFSET = 1166
    CALENDAR_DAYS_PER_MONTH = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    DAYS_PER_WEEK = 5
    DAYS_LONG     = %w[Sweetmorn Boomtime Pungenday Prickle-Prickle Setting\ Orange]
    DAYS_SHORT    = %w[SM BT PD PP SO]

    # Season are 73 days, 4 per 365 year
    DAYS_PER_SEASON = 73
    SEASONS_LONG  = %w[Chaos Discord Confusion Bureaucracy The\ Aftermath]
    SEASONS_SHORT = %w[Chs Dsc Cfn Bcy Afm]

    APOSTLE_HOLIDAY  = 4
    APOSTLE_HOLIDAYS = %w[Mungday Mojoday Syaday Zaraday Maladay] # fifth of season
    SEASON_HOLIDAY   = 49
    SEASON_HOLIDAYS  = %w[Choaflux Discoflux Confuflux Bureflux Afflux] # 50th of season

    ST_TIBS_DAY = "Feast of St. Tib's Day" # once every 4 years, inserted between 59 and 60 Season of Chaos

    EXCLAMATIONS  = [
        'Hail Eris!',
        'All Hail Discordia!',
        'Kallisti!',
        'Fnord.',
        'Or not.',
        'Wibble.',
        'Pzat!',
        "P'tang!",
        'Frink!',
        'Slack!',
        "Praise \"Bob\"!",
        'Or kill me.',
        'Grudnuk demand sustenance!',
        'Keep the Lasagna flying!',
        'You are what you see.',
        'Or is it?',
        'This statement is false.',
        'Lies and slander, sire!',
        'Hee hee hee!',
        ''
    ]
    LINUX_EXCLAMATIONS = [
        'Hail Eris, Hack Linux!',
    ]
    NON_LINUX_EXCLAMATIONS = [
        'This Fruit is not the True Fruit of Discord.',
    ]

    KILL_BOB_DATE = Date.new(8661, 6, 5)

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

      format_arguments = {
          year: year,
          day: dayactual,
          dayth: dayordinal,
          dayname: dayname,
          dayname_short: dayname_short,
          seasonname: seasonname,
          seasonname_short: seasonname_short,
          holiday: holiday,
          exclaim: exclaim,
          kill_bob: kill_bob,
          st_tibs_day: ST_TIBS_DAY
      }

      formatted = formatter.split(format).map do |part|
        part % format_arguments
      end

      if holiday.nil? && formatted.count > 1
        formatted.pop
      end

      formatted.compact.join
    end

    def leapyear?
      (year % 4) == 2
    end

    def weekday
      day % 5
    end

    def dayname
      DAYS_LONG[weekday] unless st_tibs?
    end

    def dayname_short
      DAYS_SHORT[weekday] unless st_tibs?
    end

    def seasonname
      SEASONS_LONG[season]
    end

    def seasonname_short
      SEASONS_SHORT[season]
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

    def exclaim
      @exclaims ||= if `uname`.chomp.downcase == 'linux'
                      EXCLAMATIONS.concat(LINUX_EXCLAMATIONS)
                    else
                      EXCLAMATIONS.concat(NON_LINUX_EXCLAMATIONS)
                    end
      @exclaims.sample
    end

    def kill_bob
      (KILL_BOB_DATE - @date).to_i
    end

    private

    def DY(year)
      year + YOLD_OFFSET
    end

  end
end
