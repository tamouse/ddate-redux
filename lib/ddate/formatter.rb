module Ddate
  class Formatter

    STTIBS_RE = %r|%{(.*?)}|

    def initialize(format = nil)
      if format.to_s.empty?
        @format = DEFAULT_FORMATTER
      else
        @format = Hash.new
        @format[:standard] = create_format_string_from(format.gsub(STTIBS_RE, $1))
        @format[:sttibs] = create_sttibs_from(format.gsub(STTIBS_RE, Ddate::ST_TIB_DAY))
      end
    end

    def [](key)
      if @format.has_key?(key)
        @format[key]
      else
        raise DdateException.new "invalid format key #{key}"
      end
    end

    def []=(key, value)
      if @format.has_key?(key)
        @format[key] = value
      else
        raise DdateException.new "invalid format key #{key}"
      end
    end

    def create_format_string_from(format_string)
      format_string.gsub(/%[AaBbdeHNntY.X]/, {
          '%A' => '%{dayname}', '%a' => '%{dayname}',
          '%B' => '%{seasonname}', '%b' => '%{seasonname}',
          '%d' => '%{day}', '%e' => '%{dayth}',
          '%H' => '%{holiday', '%N' => SPLIT_STOP,
          '%n' => "\n", '%t' => "\t",
          '%Y' => '%{year}', '%.' => '%{exclaim}',
          '%X' => '%{kill_bob}',
      } )

    end

  end
end
