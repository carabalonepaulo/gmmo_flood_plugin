extends Service


signal entity_born(entity)
signal entity_moved(entity)
signal entity_died(entity)


const Entity := preload("res://plugins/flood/server/services/world/entity.gd")
const EntityBornPacket := preload("res://plugins/flood/packets/responses/entity_born.gd")
const EntityMovedPacket := preload("res://plugins/flood/packets/responses/entity_moved.gd")
const EntityDiedPacket := preload("res://plugins/flood/packets/responses/entity_died.gd")


var listener: ListenerService
var dispatcher: DispatcherService
var tree: SceneTree
var _uid: UID
var _entities: Dictionary


func start() -> void:
    .start()

    _uid = UID.new()
    _entities = {}

    connect("entity_born", self, "_on_entity_born")
    connect("entity_moved", self, "_on_entity_moved")
    connect("entity_died", self, "_on_entity_died")

func stop() -> void:
    .stop()
    _uid.dispose()
    _entities.clear()

func _on_entity_born(entity: Entity) -> void:
    entity.id = _uid.get_next()

    var packet := EntityBornPacket.new()
    packet.id = entity.id
    packet.position = entity.position
    packet.size = entity.size
    packet.color = entity.color
    packet.interval = entity.interval
    listener.send_to_all(packet)

func _on_entity_moved(entity: Entity) -> void:
    var packet := EntityMovedPacket.new()
    packet.id = entity.id
    packet.position = entity.position
    listener.send_to_all(packet)

func _on_entity_died(entity: Entity) -> void:
    _uid.release(entity.id)

    var packet := EntityDiedPacket.new()
    packet.id = entity.id
    listener.send_to_all(packet)

func create_entity() -> Entity:
    var entity := Entity.new()
    entity.position = Vector2(randi() % 1024, randi() % 600)
    entity.size = randi() % 80 + 20
    entity.color = Color(randi())
    entity.step_size = randi() % 100 + 1
    entity.steps = randi() % 100
    entity.interval = randf()
    return entity

func spawn() -> void:
    var entity = yield(dispatcher.run(self, "create_entity"), "completed")
    emit_signal("entity_born", entity)

    while entity.steps > 0:
        entity.position += Vector2(randf(), randf()) * entity.step_size
        entity.steps -= 1
        emit_signal("entity_moved", entity)
        yield(tree.create_timer(entity.interval), "timeout")

    emit_signal("entity_died", entity)