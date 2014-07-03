module Ddate

  YOLD_BASE = 1970

  # Week is 5 days
  DAYS_LONG     = %w[Sweetmorn Boomtime Pungenday Prickle-Prickle Setting\ Orange]
  DAYS_SHORT    = %w[SM BT PD PP SO]

  # Season are 73 days, 5 per 365 year
  SEASONS_LONG  = %w[Chaos Discord Confusion Bureaucracy The\ Aftermath]
  SEASONS_SHORT = %w[Chs Dsc Cfn Bcy Afm]

  APOSTLE_HOLIDAYS = %w[Mungday Mojoday Syaday Zaraday Maladay] # fifth of season
  SEASON_HOLIDAYS  = %w[Choaflux Discoflux Confuflux Bureflux Afflux] # 50th of season

  ST_TIB_DAY = "St. Tib's Day" # once every 4 years, inserted between 50 and 60 Season of Chaos

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

  DEFAULT_SHORT_FMT = ->(dayname, monthname, day, year) {"#{dayname} #{monthname} #{day}, #{year} YOLD"}
  DEFAULT_LONG_FMT  = ->(dayname, dayeth, monthname, year) {
    "Today is #{dayname}, the #{dayeth} day of #{monthname} in the YOLD #{year}. Celebrate #{holiday}!"
  }

end
