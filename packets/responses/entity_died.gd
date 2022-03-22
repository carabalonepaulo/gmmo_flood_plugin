extends Packet


var id: int


func _init(): header = 2022

func serialize(writer: StreamPeerBuffer) -> void:
    .serialize(writer)

    writer.put_u32(id)

func deserialize(reader: StreamPeerBuffer) -> void:
    .deserialize(reader)

    id = reader.get_u32()