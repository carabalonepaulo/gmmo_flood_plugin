extends ClientPacketHandler


const WorldService := preload("res://plugins/flood/client/services/world/service.gd")
const EntityMovedPacket := preload("res://plugins/flood/packets/responses/entity_moved.gd")


var world: WorldService


func _init(): header = 2021

func process(packet: EntityMovedPacket) -> void:
    world.on_entity_moved(packet.id, packet.position)