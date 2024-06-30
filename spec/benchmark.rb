# frozen_string_literal: true

require "digest"
require "blake3ruby"
require "benchmark"

message = "This is a message to be hashed"

n = 5_000_000

Benchmark.bm(8) do |x|
  x.report("MD5:") { n.times { Digest::MD5.hexdigest(message) } }
  x.report("SHA1:") { n.times { Digest::SHA1.hexdigest(message) } }
  x.report("SHA3-256:") { n.times { Digest::SHA256.hexdigest(message) } }
  x.report("SHA3-384:") { n.times { Digest::SHA384.hexdigest(message) } }
  x.report("SHA3-512:") { n.times { Digest::SHA512.hexdigest(message) } }
  x.report("RMD160:") { n.times { Digest::RMD160.hexdigest(message) } }
  x.report("blake3:") { n.times { Blake3ruby.hexdigest(message) } }
end
