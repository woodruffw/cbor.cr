class CBOR::Builder
  private getter io

  def initialize(@io : IO)
  end

  private def serialize_and_free(item)
    LibCBOR.serialize_alloc item, out buf, out bufsiz
    yield Slice.new buf, bufsiz
    LibCBOR.decref pointerof(item)
    # TODO: Destroy complex types correctly
    LibC.free buf
  end

  private def build
    LibCBOR.new_null
  end

  private def build(b : Bool)
    LibCBOR.build_bool b
  end

  private def build(i : UInt8)
    LibCBOR.build_uint8 i
  end

  private def build(i : UInt16)
    LibCBOR.build_uint16 i
  end

  private def build(i : UInt32)
    LibCBOR.build_uint32 i
  end

  private def build(i : UInt64)
    LibCBOR.build_uint64 i
  end

  private def build(i : Int8)
    if i < 0
      LibCBOR.build_negint8 (-i - 1)
    else
      LibCBOR.build_uint8 i
    end
  end

  private def build(i : Int16)
    if i < 0
      LibCBOR.build_negint16 (-i - 1)
    else
      LibCBOR.build_uint16 i
    end
  end

  private def build(i : Int32)
    if i < 0
      LibCBOR.build_negint32 (-i - 1)
    else
      LibCBOR.build_uint32 i
    end
  end

  private def build(i : Int64)
    if i < 0
      LibCBOR.build_negint64 (-i - 1)
    else
      LibCBOR.build_uint64 i
    end
  end

  private def build(f : Float32)
    LibCBOR.build_float4 f
  end

  private def build(f : Float64)
    LibCBOR.build_float8 f
  end

  private def build(s : String)
    LibCBOR.build_string s
  end

  private def build(b : Bytes)
    LibCBOR.build_bytestring b, b.size
  end

  private def build(e : Enumerable)
    array = LibCBOR.new_definite_array e.size

    e.each do |v|
      item = build v
      LibCBOR.array_push array, item
    end

    array
  end

  private def build(h : Hash)
    map = LibCBOR.new_definite_map h.size

    h.each do |k, v|
      pair = LibCBOR::CBORPair.new key: (build k), value: (build v)
      LibCBOR.map_add(map, pair)
    end

    map
  end

  def null
    null = build
    serialize_and_free null do |n|
      io.write n
    end
  end

  def bool(b)
    bool = build b
    serialize_and_free bool do |b|
      io.write b
    end
  end

  def int(i : Int)
    item = build i
    serialize_and_free item do |i|
      io.write i
    end
  end

  def float(f : Float)
    item = build f
    serialize_and_free item do |f|
      io.write f
    end
  end

  def string(s : String)
    item = build s
    serialize_and_free item do |s|
      io.write s
    end
  end

  def bytes(b : Bytes)
    item = build b
    serialize_and_free item do |b|
      io.write b
    end
  end

  def array(e : Enumerable)
    array = build e
    serialize_and_free array do |e|
      io.write e
    end
  end

  def object(h : Hash)
    object = build h
    serialize_and_free object do |h|
      io.write h
    end
  end
end
