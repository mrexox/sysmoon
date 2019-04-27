module Evesync
  module Utils
    class << self
      def local_ip?(ip)
        ips = `getent hosts #{ip}`
                .lines
                .map(&:split)
                .map(&:first)
        local_ips = `ip a`
                      .lines
                      .grep(/inet/)
                      .map(&:split)
                      .map { |lines| lines[1].split('/')[0] }

        !(ips & local_ips).empty?
      end

      def local_ip
        `ip a`
          .lines
          .grep(/inet/)
          .map(&:split)
          .map { |lines| lines[1].split('/')[0] }
          .first
      end
    end
  end
end

# For ruby < 2.1
class Array
  unless defined? to_h
    def to_h
      Hash[*flatten(1)]
    end
  end
end
