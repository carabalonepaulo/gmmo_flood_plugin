extends Service


signal entity_born(id, position, size, color, interval)
signal entity_moved(id, position)
signal entity_died(id)


var SpawnEntityRequest := preload("res://plugins/flood/packets/requests/spawn_entity.gd")


var client
var _entities: Array


func start() -> void:
    .start()

func process(delta: float) -> void:
    pass

func stop() -> void:
    .stop()

func spawn_entity() -> void:
    var request := SpawnEntityRequest.new()
    for i in 100: client.send(request)

func on_entity_born(id: int, position: Vector2, size: float, color: Color, interval: float) -> void:
    emit_signal("entity_born", id, position, size, color, interval)

func on_entity_moved(id: int, position: Vector2) -> void:
    emit_signal("entity_moved", id, position)

func on_entity_died(id: int) -> void:
    emit_signal("entity_died", id)
