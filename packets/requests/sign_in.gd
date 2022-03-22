extends Packet


var name: String
var color: Color


func _init(): header = 2000

func serialize(writer: StreamPeerBuffer) -> void:
    .serialize(writer)

    writer.put_utf8_string(name)
    writer.put_u8(color.r8)
    writer.put_u8(color.g8)
    writer.put_u8(color.b8)
    writer.put_u8(color.a8)

func deserialize(reader: StreamPeerBuffer) -> void:
    .deserialize(reader)

    name = reader.get_utf8_string()
    color = Color(reader.get_u8(), reader.get_u8(), reader.get_u8(), reader.get_u8())