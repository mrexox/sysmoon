require 'sysmoon/constants'

module Sysmoon
  # = Constants for Sysmoon::IPC module
  #
  #   no constants yet
  module IPC
      private

      def check_params_provided(params, keys)
        keys.each do |param|
          raise RuntimeError.new(":#{param} missed") unless
            params.key?(param)
        end
      end

      def get_port(params)
        port = params[:port]
        p = case port
            when :sysmoond then Configuration::SYSMOOND_PORT
            when :sysdatad then Configuration::SYSDATAD_PORT
            when :syshand then Configuration::SYSHAND_PORT
            else
              port_i = port.to_i
              unless port_i < 65535 and port_i > 49152
                raise RuntimeError.("Port MUST be in (49152..65535)")
              end
              port
            end
        p
      end
  end
end