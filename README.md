CBOR.cr
====

Crystal bindings for [libcbor](https://github.com/PJK/libcbor).

## Status

- [x] Serialization (`to_cbor`)
- [ ] Deserialization (`from_cbor`)
- [ ] `JSON.mapping`-style API
- [ ] Nice error handling
- [ ] Unit tests

## Installation

1. Make sure you have `libcbor` installed. Your package manager probably provides it.

2. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     CBOR:
       github: woodruffw/cbor.cr
   ```

3. Run `shards install`

## Usage

```crystal
require "CBOR"

# Note: These print binary data!
puts -1.to_cbor
puts nil.to_cbor
puts true.to_cbor
puts 3.14.to_cbor
puts "abc".to_cbor
puts [1, 2, 3, "four"].to_cbor
puts Hash{"key" => "value"}.to_cbor
puts Time.now.to_cbor
```

CBOR.cr does not currently provide a mapping-style API, like the core JSON or YAML modules.
To serialize custom objects to CBOR, define `#to_h` on them and use `to_h.to_cbor`.

## Contributing

1. Fork it (<https://github.com/woodruffw/CBOR/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [William Woodruff](https://github.com/woodruffw) - creator and maintainer
