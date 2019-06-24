require "./CBOR/*"

# TODO: Write documentation for `CBOR`
module CBOR
  VERSION = "0.1.0"

  def self.build(io : IO)
    builder = CBOR::Builder.new(io)
    yield builder
  end
end

# puts -1.to_cbor.to_slice.hexstring
# puts nil.to_cbor.to_slice.hexstring
# puts true.to_cbor.to_slice.hexstring
# puts 3.14.to_cbor.to_slice.hexstring
# puts "abc".to_cbor.to_slice.hexstring
# puts [1, 2, 3, "four"].to_cbor.to_slice.hexstring
# puts Hash{"key" => "value"}.to_cbor.to_slice.hexstring
# puts Time.now.to_cbor.to_slice.hexstring
