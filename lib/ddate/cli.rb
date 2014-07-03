require 'singleton'

module Ddate
  class CLI

    FORMAT_RE = %r{\A\+(.*)\z}
    OPTION_RE = %r{\A\-(\S)\z}

    attr_accessor :formatter

    def initialize
      self.formatter = Ddate::Formatter.new
    end

    def run(args)

      num_args = args.count
      case num_args
      when 0
        # no arguments, run with today's date
        today = Date.today
        year, month, day = today.year, today.month, today.day
      when 1
        arg = args.shift.to_s
        if (help = arg.to_s.match(OPTION_RE) {|m| handle_options($1)})
          return help
        elsif (self.formatter = arg.to_s.match(FORMAT_RE) {|m| Ddate::Formatter.new($1)})
          # do nothing, drop through
        else
          raise DdateException.new "not enough arguments"
        end
        today = Date.today
        year, month, day = today.year, today.month, today.day
      when 3
        day, month, year = args.map { |i| Integer(i) }
      when 4
        fmt = args.shift.to_s
        if (self.formatter = fmt.match(FORMAT_RE) {|m| Ddate::Formatter.new($1)})
          # do nothing, drop through
        else
          raise DdateException.new "first argument when 4 given must be a format"
        end
        day, month, year = args.map { |i| Integer(i) }
      else
        raise DdateException.new "wrong number of arguments"
      end
      Ddate::Converter.new(year, month, day, formatter).to_s
    end

    def handle_options(option)
      case option.downcase
      when 'h'
        Ddate::USAGE
      when 'f'
        Ddate::FORMATTER_USAGE
      when 'v'
        Ddate::VERSION_STRING
      else
        raise DdateException.new "unknown option: #{option}"
      end
    end

  end
end
