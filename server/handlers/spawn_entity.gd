extends ServerPacketHandler


const WorldService := preload("res://plugins/flood/server/services/world/service.gd")
const SpawnEntityRequest := preload("res://plugins/flood/packets/requests/spawn_entity.gd")


var world: WorldService


func _init(): header = 2030

func process(sender_id: int, request: SpawnEntityRequest) -> void:
    world.spawn()