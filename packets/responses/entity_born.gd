extends Packet


var id: int
var position: Vector2
var size: float
var color: Color
var interval: float


func _init(): header = 2020

func serialize(writer: StreamPeerBuffer) -> void:
    .serialize(writer)

    writer.put_u32(id)
    writer.put_float(position.x)
    writer.put_float(position.y)
    writer.put_float(size)
    writer.put_u8(color.r8)
    writer.put_u8(color.g8)
    writer.put_u8(color.b8)
    writer.put_u8(color.a8)
    writer.put_float(interval)


func deserialize(reader: StreamPeerBuffer) -> void:
    .deserialize(reader)

    id = reader.get_u32()
    position = Vector2(reader.get_float(), reader.get_float())
    size = reader.get_float()
    color = Color8(reader.get_u8(), reader.get_u8(), reader.get_u8(), reader.get_u8())
    interval = reader.get_float()