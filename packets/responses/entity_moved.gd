extends Packet


var id: int
var position: Vector2


func _init(): header = 2021

func serialize(writer: StreamPeerBuffer) -> void:
    .serialize(writer)

    writer.put_u32(id)
    writer.put_float(position.x)
    writer.put_float(position.y)

func deserialize(reader: StreamPeerBuffer) -> void:
    .deserialize(reader)

    id = reader.get_u32()
    position = Vector2(reader.get_float(), reader.get_float())