extends Packet


var name: String


func _init(): header = 2000

func serialize(writer: StreamPeerBuffer) -> void:
    .serialize(writer)

    writer.put_utf8_string(name)

func deserialize(reader: StreamPeerBuffer) -> void:
    .deserialize(reader)

    name = reader.get_utf8_string()