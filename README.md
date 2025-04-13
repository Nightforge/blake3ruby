# Blake3ruby

[![Gem Version](https://badge.fury.io/rb/blake3ruby.svg)](https://badge.fury.io/rb/blake3ruby)

This is a Ruby wrapper for the [BLAKE3](https://github.com/BLAKE3-team/BLAKE3) hash function written in Rust.

## Requirements
Tested on Ruby 3.1, 3.2, 3.3 and 3.4.
You will need to have Rust installed on your system, and the `cargo` command available in your path.
See [here](https://www.rust-lang.org/tools/install) for instructions on how to install Rust.
Rust is only required to build the gem, not to use it.
Minimally, you will need Rust 1.6 or later.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'blake3ruby'
```

And then execute:

    bundle install

It will take a while to build the gem, as it needs to compile the Rust code including the [BLAKE3](https://github.com/BLAKE3-team/BLAKE3) library and dependencies.

If bundler is not being used to manage dependencies, install the gem by executing:

    gem install blake3ruby

## Usage

Basic usage is similar to the `Digest` class in the Ruby standard library:
```ruby
require 'blake3ruby'

Digest::Blake3.hexdigest("Hello, world!") # => "ede5c0b10f2ec4979c69b52f61e42ff5b413519ce09be0f14d098dcfe5f6f98d"
```

If you want to use the streaming interface, you can use the `Blake3ruby::Hasher` class:

```ruby
require 'blake3ruby'

hasher = Digest::Blake3::Hasher.new
hasher.update("Hello, ") # => #<Digest::Blake3::Hasher:0x00000001066f59a8> - returns self
hasher.update("world!")
hasher.finalize # => "ede5c0b10f2ec4979c69b52f61e42ff5b413519ce09be0f14d098dcfe5f6f98d"
```

You can also use the `Blake3ruby` module for deriving keys:

Quoting from the [BLAKE3 documentation](https://github.com/BLAKE3-team/BLAKE3#the-blake3-crate-)
```
The derive_key mode takes a context string and some key material (not a password). The context string should be hardcoded, globally unique, and application-specific. A good default format for the context string is "[application] [commit timestamp] [purpose]"
```

```ruby
require 'blake3ruby'

Digest::Blake3.derive_key("context", "input_key_material") # => "3eaa9796d6d3db5cd5de00d44e4888fccbf4f8c878dd6ccd0c374bded6c26405"
```

## Breaking Changes in Version 0.2.0

In versions 0.1.0 and 0.1.1, the Blake3ruby namespace was available. Starting from version 0.2.0, the Blake3 crypto digest has been moved to the Digest namespace where all standard Ruby digests are available. This change ensures consistency and better integration with the Ruby standard library.

## Performance

The performance of this gem is comparable to the performance of the [blake3](https://github.com/BLAKE3-team/BLAKE3)
crate, which is written in Rust.

The following benchmark was run on a 2015 MacBook Pro with a 2.5 GHz 4-Core Intel Core i7 processor and 16 GB of RAM.
 ```
MD5 (13 chars):        6.141045   0.086745   6.227790 (  6.263524)
SHA1 (13 chars):       6.230957   0.080145   6.311102 (  6.333384)
SHA3-256 (13 chars):   6.364485   0.093261   6.457746 (  6.491053)
SHA3-384 (13 chars):   7.068870   0.151501   7.220371 (  7.246571)
SHA3-512 (13 chars):   7.265794   0.152058   7.417852 (  7.443591)
RMD160 (13 chars):     5.547123   0.075290   5.622413 (  5.642165)
blake3 (13 chars):     2.747356   0.014433   2.761789 (  2.772582)

For message length 13 chars:
Fastest: blake3 with 2.7725820001214743 seconds
Slowest: SHA3-512 with 7.44359099981375 seconds
                           user     system      total        real
MD5 (44 chars):        5.861548   0.074899   5.936447 (  5.959032)
SHA1 (44 chars):       5.944156   0.072394   6.016550 (  6.038251)
SHA3-256 (44 chars):   6.446754   0.096381   6.543135 (  6.570512)
SHA3-384 (44 chars):   7.083944   0.156259   7.240203 (  7.268630)
SHA3-512 (44 chars):   7.213243   0.154452   7.367695 (  7.396536)
RMD160 (44 chars):     5.589189   0.075830   5.665019 (  5.689458)
blake3 (44 chars):     2.754475   0.014872   2.769347 (  2.780263)

For message length 44 chars:
Fastest: blake3 with 2.7802629999350756 seconds
Slowest: SHA3-512 with 7.396536000072956 seconds
                           user     system      total        real
MD5 (199 chars):       8.079411   0.088239   8.167650 (  8.201427)
SHA1 (199 chars):      7.792639   0.082953   7.875592 (  7.904909)
SHA3-256 (199 chars):  9.508372   0.106791   9.615163 (  9.648153)
SHA3-384 (199 chars):  8.291785   0.160924   8.452709 (  8.483978)
SHA3-512 (199 chars):  8.396180   0.160054   8.556234 (  8.590455)
RMD160 (199 chars):    8.910650   0.087215   8.997865 (  9.028016)
blake3 (199 chars):    3.796439   0.018845   3.815284 (  3.829479)

For message length 199 chars:
Fastest: blake3 with 3.8294790000654757 seconds
Slowest: SHA3-256 with 9.648153000045568 seconds
                           user     system      total        real
MD5 (1024 chars):     15.504161   0.114951  15.619112 ( 15.671606)
SHA1 (1024 chars):    13.007605   0.105566  13.113171 ( 13.163242)
SHA3-256 (1024 chars): 20.968764   0.162367  21.131131 ( 21.212766)
SHA3-384 (1024 chars): 17.255475   0.300950  17.556425 ( 17.728562)
SHA3-512 (1024 chars): 17.697881   0.400774  18.098655 ( 18.404827)
RMD160 (1024 chars):  23.639904   0.458113  24.098017 ( 24.535302)
blake3 (1024 chars):   8.123303   0.178863   8.302166 (  8.499843)

For message length 1024 chars:
Fastest: blake3 with 8.499842999968678 seconds
Slowest: RMD160 with 24.535302000120282 seconds
```

Another benchmark was run on a 2022 MacBook Pro with a Apple M1 processor and 16 GB of RAM.
 ```
               user     system      total        real
MD5:       4.080778   0.029457   4.110235 (  4.388991)
SHA1:      3.736124   0.030763   3.766887 (  3.991860)
SHA3-256:  3.511138   0.036125   3.547263 (  3.664061)
SHA3-384:  4.009041   0.085845   4.094886 (  4.094987)
SHA3-512:  4.078389   0.071463   4.149852 (  4.149982)
RMD160:    2.965860   0.026660   2.992520 (  3.216815)
blake3:    1.715370   0.004587   1.719957 (  1.719995)
```

In both cases, the `blake3ruby` gem was about 2.5 times faster than the md5, sha1, sha3-256, sha3-384, sha3-512, and rmd160 digest algorithms.

You can run the benchmarks yourself by cloning this repository and running `ruby spec/benchmark.rb`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT) and the Ruby license.


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

Pull requests are welcome.

## How create a new pull request

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
6. Wait for review

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Nightforge/blake3ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/blake3ruby/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the Blake3ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/blake3ruby/blob/master/CODE_OF_CONDUCT.md).
