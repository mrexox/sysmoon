require 'logger'
require 'evesync/config'
require 'evesync/constants'

# This module is responsible for logging
module Evesync
  module Log
    # Supported levels for logging
    LEVELS = %i[debug info warn error fatal].freeze

    class << self
      def method_missing(m, *args)
        # You cannot setup logger from anywhere
        raise NoMethodError until LEVELS.include?(m)

        check_logger
        @logger.send(m, to_string(*args))
        nil
      end

      def check_logger
        init_logger until @logger
      end

      def init_logger
        @logger = Logger.new(STDERR)
        @logger.formatter = proc do |sev, dtime, _prog, msg|
          time = dtime.strftime('%Y-%m-%d %H:%M:%S')
          prog = File.basename($PROGRAM_NAME)
          "[#{time}] #{prog.ljust(8)} #{sev.ljust(5)}: #{msg}\n"
        end
        @logger.level = read_loglevel
      end

      def to_string(*args)
        to_s_with_space = ->(s) { "#{s} " }
        args.map(&to_s_with_space).reduce(&:+).strip
      end

      private

      def read_loglevel
        level = Config['loglevel'] || Constants::DEFAULT_LOGLEVEL
        begin
          return Logger.const_get(level.upcase)
        rescue NameError
          # TODO: log about it
          return Logger::DEBUG
        end
      end
    end
  end
end
