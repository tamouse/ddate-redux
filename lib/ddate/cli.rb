module Ddate
  class CLI
    include Singleton

    def main(args, stdout=STDOUT, stderr=STDERR)

      @formats = Ddate::Formatter.new

      begin

        num_args = args.count
        case num_args
        when 0
          # no arguments, run with today's date
          today = Date.today
          year, month, day = today.year, today.month, today.day
        when 1
          raise DdateException.new "not enough arguments" unless check_arg(args.first)
        when 3
          year, month, day = args.map { |i| Integer(i) }
        when 4
          fmt = args.shift.to_s
          if fmt[0] == "+"
            @formats = Ddate::Formatter.new(fmt)
          else
            raise DdateException.new "first argument when 4 given must be a format"
          end
          year, month, day = args.map { |i| Integer(i) }
        else
          raise DdateException.new "wrong number of arguments"
        end
        puts Ddate::Converter.new(year, month, day, @formats[:standard], @formats[:sttibs])

      rescue DdateException => e
        STDERR.puts "#{e.class.name}: #{e}"
        STDERR.puts Ddate::Usage
      end

    end

    def check_arg(arg)
      arg = arg.to_s
      if arg.size < 1
        raise DdateException.new "invalid first argument"
      elsif arg[0] == "+"
        @formats = Ddate::Formatter.new(arg)
        return true
      elsif arg1[0] == '-'
        handle_options(arg1)
        return true
      end
      return false
    end

    def handle_options(arg)
      arg.to_s.split('').each do |c|
        next if c = '-'

        case c.downcase
        when 'h'
          STDERR.puts Ddate::Usage
        when 'f'
          STDERR.puts Ddate::Formatter::USAGE
        when 'v'
          STDERR.puts Ddate::VERSION_STRING
        else
          raise DdateException.new "unknown option: #{c}"
        end
      end
    end

  end
end
