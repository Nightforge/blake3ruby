# Blake3ruby

[![Gem Version](https://badge.fury.io/rb/blake3ruby.svg)](https://badge.fury.io/rb/blake3ruby)

This is a Ruby wrapper for the [BLAKE3](https://github.com/BLAKE3-team/BLAKE3) hash function written in Rust.

## Requirements
Tested on Ruby 3.1 and 3.2.
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

Blake3ruby.hexdigest("Hello, world!") # => "ede5c0b10f2ec4979c69b52f61e42ff5b413519ce09be0f14d098dcfe5f6f98d"
```

If you want to use the streaming interface, you can use the `Blake3ruby::Hasher` class:

```ruby
require 'blake3ruby'

hasher = Blake3ruby::Hasher.new
hasher.update("Hello, ") # => #<Blake3ruby::Hasher:0x00007f9b0a0b0e00> - returns self
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

Blake3ruby.derive_key("context", "input_key_material") # => "3eaa9796d6d3db5cd5de00d44e4888fccbf4f8c878dd6ccd0c374bded6c26405"
```

## Performance

The performance of this gem is comparable to the performance of the [blake3](https://github.com/BLAKE3-team/BLAKE3)
crate, which is written in Rust.

The following benchmark was run on a 2015 MacBook Pro with a 2.5 GHz 4-Core Intel Core i7 processor and 16 GB of RAM.    
 ```
               user     system      total        real
MD5:       6.376103   0.028610   6.404713 (  6.492484)
SHA1:      5.701825   0.014154   5.715979 (  5.721241)
SHA3-256:  6.081136   0.014625   6.095761 (  6.102179)
SHA3-384:  6.757476   0.013765   6.771241 (  6.778101)
SHA3-512:  6.890564   0.014625   6.905189 (  6.909914)
RMD160:    6.196825   0.031562   6.228387 (  6.293669)
blake3:    2.527779   0.006833   2.534612 (  2.536978)
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
