require "./CBOR/*"

# TODO: Write documentation for `CBOR`
module CBOR
  VERSION = "0.1.0"

  def self.build(io : IO)
    builder = CBOR::Builder.new(io)
    yield builder
  end
end
