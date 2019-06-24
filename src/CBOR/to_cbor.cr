class Object
  def to_cbor
    io = IO::Memory.new
    to_cbor io
    io
  end

  def to_cbor(io : IO)
    CBOR.build(io) do |cbor|
      to_cbor cbor
    end
  end
end

struct Nil
  def to_cbor(cbor : CBOR::Builder)
    cbor.null
  end
end

struct Bool
  def to_cbor(cbor : CBOR::Builder)
    cbor.bool self
  end
end

struct Int
  def to_cbor(cbor : CBOR::Builder)
    cbor.int self
  end
end

struct Float
  def to_cbor(cbor : CBOR::Builder)
    cbor.float self
  end
end

class String
  def to_cbor(cbor : CBOR::Builder)
    cbor.string self
  end
end

struct Slice
  def to_cbor(cbor : CBOR::Builder)
    self.as(Slice(UInt8))

    cbor.bytes self
  end
end

struct Symbol
  def to_cbor(cbor : CBOR::Builder)
    cbor.string to_s
  end
end

class Array
  def to_cbor(cbor : CBOR::Builder)
    cbor.array self
  end
end

struct Set
  def to_cbor(cbor : CBOR::Builder)
    cbor.array self
  end
end

class Hash
  def to_cbor(cbor : CBOR::Builder)
    cbor.object self
  end
end

struct Tuple
  def to_cbor(cbor : CBOR::Builder)
    cbor.array self
  end
end

struct NamedTuple
  def to_cbor(cbor : CBOR::Builder)
    cbor.object self
  end
end

struct Time::Format
  def to_cbor(value : Time, cbor : CBOR::Builder)
    format(value).to_cbor(cbor)
  end
end

struct Enum
  def to_cbor(cbor : CBOR::Builder)
    cbor.int to_i
  end
end

struct Time
  def to_cbor(cbor : CBOR::Builder)
    cbor.string Time::Format::RFC_3339.format(self, fraction_digits: 0)
  end
end

module Time::EpochConverter
  def to_cbor(cbor : CBOR::Builder)
    cbor.int to_unix
  end
end

module Time::EpochMillisConverter
  def to_cbor(cbor : CBOR::Builder)
    cbor.int to_unix_ms
  end
end
