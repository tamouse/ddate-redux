# -*- coding: utf-8 -*-
module Ddate
  VERSION = '1.0.3'

  AUTHORS = ['Tamara Temple']
  EMAILS  = ['tamouse@gmail.com']
  HOMEPAGE = 'https://github.com/tamouse/ddate-redux'
  LICENSE = 'MIT'

  PACKAGE = 'ddate-redux'
  PROGNAME = File.basename($0)
  VERSION_STRING = "#{PROGNAME}: #{PACKAGE} #{VERSION}"
  USAGE = "Usage: #{PROGNAME} [ -h | -v ] [+format] [day month year]"
  FORMATTER_USAGE = %q[

Format strings work just like the old ddate(1) program:

       If a format string is specified, the Discordian date will be printed in
       a format specified by the string. This mechanism works similarly to the
       format string mechanism of date(1), only almost completely differently.
       The fields are:

       %A     Full name of the day of the week (i.e., Sweetmorn)

       %a     Abbreviated name of the day of the week (i.e., SM)

       %B     Full name of the season (i.e., Chaos)

       %b     Abbreviated name of the season (i.e., Chs)

       %d     Ordinal number of day in season (i.e., 23)

       %e     Cardinal number of day in season (i.e., 23rd)

       %H     Name of current Holyday, if any

       %N     Magic  code  to prevent rest of format from being printed unless
              today is a Holyday.

       %n     Newline

       %t     Tab

       %X     Number of days remaining until X-Day. (Not valid if  the  SubGe-
              nius options are not compiled in.)

       %{

       %}     Used  to  enclose the part of the string which is to be replaced
              with the words "St. Tib’s Day" if the current day is  St.  Tib’s
              Day.

       %.     Try it and see.

Examples:

       % ddate
       Sweetmorn, Bureaucracy 42, 3161 YOLD

       % ddate +’Today is %{%A, the %e of %B%}, %Y. %N%nCelebrate %H’
       Today is Sweetmorn, the 42nd of Bureaucracy, 3161.

       % ddate +"It’s %{%A, the %e of %B%}, %Y. %N%nCelebrate %H" 26 9 1995
       It’s Prickle-Prickle, the 50th of Bureaucracy, 3161.
       Celebrate Bureflux

       % ddate +"Today’s %{%A, the %e of %B%}, %Y. %N%nCelebrate %H" 29 2 1996
       Today’s St. Tib’s Day, 3162.

  ]
end
