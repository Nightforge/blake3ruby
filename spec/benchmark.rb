# frozen_string_literal: true

require "digest"
require "blake3ruby"
require "benchmark"

messages = [
  "Short message",
  "This is a medium length message to be hashed",
  "This is a much longer message designed to see how the algorithms perform when dealing with a significantly larger amount of data, which should provide a better overall benchmark of their performance."
]

n = 5_000_000

Benchmark.bm(20) do |x|
  messages.each do |message|
    length = message.length
    x.report("MD5 (#{length} chars):") { n.times { Digest::MD5.hexdigest(message) } }
    x.report("SHA1 (#{length} chars):") { n.times { Digest::SHA1.hexdigest(message) } }
    x.report("SHA3-256 (#{length} chars):") { n.times { Digest::SHA256.hexdigest(message) } }
    x.report("SHA3-384 (#{length} chars):") { n.times { Digest::SHA384.hexdigest(message) } }
    x.report("SHA3-512 (#{length} chars):") { n.times { Digest::SHA512.hexdigest(message) } }
    x.report("RMD160 (#{length} chars):") { n.times { Digest::RMD160.hexdigest(message) } }
    x.report("blake3 (#{length} chars):") { n.times { Blake3ruby.hexdigest(message) } }
  end
end
