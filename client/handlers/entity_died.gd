extends ClientPacketHandler


const WorldService := preload("res://plugins/flood/client/services/world/service.gd")
const EntityDiedPacket := preload("res://plugins/flood/packets/responses/entity_died.gd")


var world: WorldService


func _init(): header = 2022

func process(packet: EntityDiedPacket) -> void:
    world.on_entity_died(packet.id)