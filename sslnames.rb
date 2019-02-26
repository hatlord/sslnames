#!/usr/bin/env ruby

#./sslnames.rb path_to_sslscan_text_files
@sslscan_files = Dir.glob(ARGV[0] + '/*.txt')

@sslscan_files.each do |file|
  sslscan = File.readlines(file).map(&:chomp &&:strip)
  ip = sslscan[4].split(" ")[2]
  port = sslscan[0].split(":")[1]
  subject   = sslscan.select { |i| i[/Subject:/]}
  signature = sslscan.select { |i| i[/Signature Algorithm:/]}
  hostname  = subject.map { |s| s.split(" ")[1]}
  hostname.each do |name|
    signature.each do |sig|
      puts "#{ip}\t#{name}\t#{sig}\t#{port}"
    end
  end
end
