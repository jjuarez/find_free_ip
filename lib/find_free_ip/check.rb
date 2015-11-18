# encoding: utf-8
require 'thor'
require 'ipaddr'


module FindFreeIP
  class Check < Thor

    DEFAULT_TIMEOUT  = 1
    DEFAULT_TRIES    = 1
    DEFAULT_EXCLUDED = [0,1,2,3,4,5,6,7,8,9,10,254]

    no_tasks do

      def ping(ip_address)
        system("ping -q -W #{DEFAULT_TIMEOUT} -c #{DEFAULT_TRIES} #{ip_address}", [:err, :out] => "/dev/null")
      end
    end

    desc "find", "Tries to find a free IP in a network"
    option :network, :required =>true,  :type =>:string, :aliases =>'-n', :desc =>'The base directory for the backups'
    def find()

      network = IPAddr.new(options[:network]).to_range

      network.each do |ip_address|

        nh = ip_address.to_s.split('.').last.to_i

        unless DEFAULT_EXCLUDED.include?(nh)
          $stdout.puts ip_address unless ping(ip_address)
        end
      end
    end

    default_task :find
  end
end
