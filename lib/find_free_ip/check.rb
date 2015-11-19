# encoding: utf-8
require 'thor'
require 'ipaddress'


module FindFreeIP
  class Check < Thor

    DEFAULT_TIMEOUT = 1
    DEFAULT_TRIES   = 1

    no_tasks do

      def ping(ip_address)
        system("ping -q -W #{DEFAULT_TIMEOUT} -c #{DEFAULT_TRIES} #{ip_address}", [:err, :out] => "/dev/null")
      end
    end


    desc "find", "Tries to find a free IP in a network"
    option :network,  :required =>true,  :type =>:string, :aliases =>'-n', :desc =>'The CIDR IP expression'
    option :reserved, :required =>false, :type =>:string, :aliases =>'-r', :default => '', :desc =>'The host reserved in the network'
    def find()

      reserved = options[:reserved].split(',').map { |r| r.to_i } 
      network  = IPAddress.parse(options[:network])

      network.each do |ip_address|

        next if reserved.include?(ip_address.to_s.split('.').last.to_i)

        $stdout.puts ip_address unless ping(ip_address)
      end
    end

    default_task :find
  end
end
