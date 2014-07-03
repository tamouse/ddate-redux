module Ddate
  class Formatter

    STTIBS_RE = %r|%{(.*?)%}|

    SPLIT_STOP = '%%N'

    DEFAULT_FORMAT = '%{%A, %B the %e%}, YOLD %Y.%N Celebrate %H!'

    attr_reader :standard, :sttibs

    def initialize(format = nil)
      format = DEFAULT_FORMAT if format.to_s.empty?
      @standard = create_format_string_from(format.gsub(STTIBS_RE){$1})
      @sttibs = create_format_string_from(format.gsub(STTIBS_RE, '%{st_tibs_day}'))
    end

    def create_format_string_from(format_string)
      format_string.gsub(/%[AaBbdeHNntY.X]/, {
          '%A' => '%{dayname}', '%a' => '%{dayname_short}',
          '%B' => '%{seasonname}', '%b' => '%{seasonname_short}',
          '%d' => '%{day}', '%e' => '%{dayth}',
          '%H' => '%{holiday}', '%N' => SPLIT_STOP,
          '%n' => "\n", '%t' => "\t",
          '%Y' => '%{year}', '%.' => '%{exclaim}',
          '%X' => '%{kill_bob}',
      } )

    end

    def split(key)
      send(key).split(SPLIT_STOP, 2)
    end

  end
end
