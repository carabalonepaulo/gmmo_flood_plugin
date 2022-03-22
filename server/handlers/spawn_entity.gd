extends ServerPacketHandler


const WorldService := preload("res://plugins/flood/server/services/world/service.gd")
const SpawnEntityRequest := preload("res://plugins/flood/packets/requests/spawn_entity.gd")


var world: WorldService


func _init(): header = 2030

func can_process() -> bool:
    return true

func process(request: SpawnEntityRequest) -> void:
    world.spawn()