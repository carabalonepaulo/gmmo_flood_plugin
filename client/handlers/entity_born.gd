extends ClientPacketHandler


const WorldService := preload("res://plugins/flood/client/services/world/service.gd")
const EntityBornPacket := preload("res://plugins/flood/packets/responses/entity_born.gd")


var world: WorldService


func _init(): header = 2020

func process(packet: EntityBornPacket) -> void:
    world.on_entity_born(packet.id, packet.position, packet.size, packet.color, packet.interval)
