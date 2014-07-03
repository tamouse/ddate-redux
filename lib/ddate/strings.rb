module Ddate

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

  ST_TIB_DAY = "Feast of St. Tib's Day" # once every 4 years, inserted between 59 and 60 Season of Chaos

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

  DEFAULT_FORMATTER = {
      :standard => ->(year, dayname, seasonname, day, dayth, holiday, exclaim) {"#{holiday.nil? ? "" : "#{holiday}, "}#{dayname}, #{seasonname}, #{dayth}, #{year} YOLD"},
      :sttibs   => ->(year, dayname, seasonname, day, dayth, holiday, exclaim) {"#{ST_TIB_DAY}, #{year} YOLD"}
  }

end
