# frozen_string_literal: true

require "digest"
require "blake3ruby"
require "benchmark"

messages = [
  "Short message",
  "This is a medium length message to be hashed",
  "This is a much longer message designed to see how the algorithms perform when dealing with a significantly larger amount of data, which should provide a better overall benchmark of their performance.",
  "A" * 1024
]

n = 5_000_000

algorithms = {
  "MD5" => ->(msg) { Digest::MD5.hexdigest(msg) },
  "SHA1" => ->(msg) { Digest::SHA1.hexdigest(msg) },
  "SHA3-256" => ->(msg) { Digest::SHA256.hexdigest(msg) },
  "SHA3-384" => ->(msg) { Digest::SHA384.hexdigest(msg) },
  "SHA3-512" => ->(msg) { Digest::SHA512.hexdigest(msg) },
  "RMD160" => ->(msg) { Digest::RMD160.hexdigest(msg) },
  "blake3" => ->(msg) { Digest::Blake3.hexdigest(msg) }
}

messages.each do |message|
  results = {}

  Benchmark.bm(20) do |x|
    length = message.length
    algorithms.each do |name, algo|
      report = x.report("#{name} (#{length} chars):") { n.times { algo.call(message) } }
      results[name] = report.real
    end
  end

  fastest = results.min_by { |_, time| time }
  slowest = results.max_by { |_, time| time }

  puts "\nFor message length #{message.length} chars:"
  puts "Fastest: #{fastest[0]} with #{fastest[1]} seconds"
  puts "Slowest: #{slowest[0]} with #{slowest[1]} seconds"
end
