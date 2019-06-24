module CBOR
  @[Link("cbor")]
  lib LibCBOR
    # TODO(ww): Maybe give this a real type, or extract the actual structure.
    type CBORItem = Void*
    alias CBORData = UInt8*

    enum IntWidth
      INT_8
      INT_16
      INT_32
      INT_64
    end

    enum ErrorCode
      ERR_NONE
      ERR_NOTENOUGHDATA
      ERR_NODATA
      ERR_MALFORMATTED
      ERR_MEMERROR
      ERR_SYNTAXERROR
    end

    struct Error
      position : LibC::SizeT
      error_code : ErrorCode
    end

    struct LoadResult
      error : Error
      read : LibC::SizeT
    end

    struct CBORPair
      key : CBORItem
      value : CBORItem
    end

    # Serialization
    fun serialize_alloc = cbor_serialize_alloc(item : CBORItem, buffer : CBORData*, buffer_size : LibC::SizeT*)

    # Deserialization
    fun load = cbor_load(source : CBORData, source_size : LibC::SizeT, load_result : LoadResult*)

    # Memory management
    fun decref = cbor_decref(item : CBORItem*)

    # Types 0 and 1: Positive/negative integers
    fun build_uint8 = cbor_build_uint8(value : UInt8) : CBORItem
    fun build_uint16 = cbor_build_uint16(value : UInt16) : CBORItem
    fun build_uint32 = cbor_build_uint32(value : UInt32) : CBORItem
    fun build_uint64 = cbor_build_uint64(value : UInt64) : CBORItem
    fun build_negint8 = cbor_build_negint8(value : UInt8) : CBORItem
    fun build_negint16 = cbor_build_negint16(value : UInt16) : CBORItem
    fun build_negint32 = cbor_build_negint32(value : UInt32) : CBORItem
    fun build_negint64 = cbor_build_negint64(value : UInt64) : CBORItem

    fun get_uint8 = cbor_get_uint8(item : CBORItem) : UInt8
    fun get_uint16 = cbor_get_uint16(item : CBORItem) : UInt16
    fun get_uint32 = cbor_get_uint32(item : CBORItem) : UInt32
    fun get_uint64 = cbor_get_uint64(item : CBORItem) : UInt64

    fun set_uint8 = cbor_set_uint8(item : CBORItem, value : UInt8) : Void
    fun set_uint16 = cbor_set_uint16(item : CBORItem, value : UInt16) : Void
    fun set_uint32 = cbor_set_uint32(item : CBORItem, value : UInt32) : Void
    fun set_uint64 = cbor_set_uint64(item : CBORItem, value : UInt64) : Void

    fun int_get_width = cbor_int_get_width(item : CBORItem) : IntWidth
    fun mark_uint = cbor_mark_uint(item : CBORItem)
    fun mark_negint = cbor_mark_negint(item : CBORItem)

    # Type 2: Byte strings
    fun build_bytestring = cbor_build_bytestring(value : CBORData, length : LibC::SizeT) : CBORItem

    # Type 3: UTF-8 strings
    fun build_string = cbor_build_string(value : UInt8*) : CBORItem

    # Type 4: Arrays
    fun new_definite_array = cbor_new_definite_array(size : LibC::SizeT) : CBORItem
    fun array_push = cbor_array_push(array : CBORItem, pushee : CBORItem) : Bool

    # Type 5: Maps
    fun new_definite_map = cbor_new_definite_map(size : LibC::SizeT) : CBORItem
    fun map_add = cbor_map_add(map : CBORItem, pair : CBORPair)

    # Type 6: Semantic tags
    # Currently unused.

    # Type 7: Floats and control values
    fun build_float4 = cbor_build_float4(value : Float32) : CBORItem
    fun build_float8 = cbor_build_float8(value : Float32) : CBORItem
    fun build_bool = cbor_build_bool(value : Bool) : CBORItem
    fun new_null = cbor_new_null : CBORItem
  end
end
