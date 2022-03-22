extends Node2D


const WorldService := preload("res://plugins/flood/client/services/world/service.gd")
const Entity := preload("res://plugins/flood/client/scenes/world/entity/entity.tscn")


onready var main = get_tree().root.get_node("main")
onready var world: WorldService = main.services.world


onready var _tween: Tween = $Tween
onready var _fps: Label = $ui/fps
onready var _count: Label = $ui/entities
onready var _container: Node = $entities2

# var _entity: Node2D
var _entities := {}
var _entities_count = 0


func _ready():
    world.connect("entity_born", self, "_on_entity_born")
    world.connect("entity_moved", self, "_on_entity_moved")
    world.connect("entity_died", self, "_on_entity_died")

func _on_entity_born(id: int, position: Vector2, size: float, color: Color, interval: float) -> void:
    var entity := Entity.instance()
    entity.position = position
    entity.size = size
    entity.color = color
    entity.interval = interval
    _entities[id] = entity
    _container.add_child(entity)
    _entities_count += 1
    _count.text = "Entities: " + str(_entities_count)

func _on_entity_moved(id: int, position: Vector2) -> void:
#    if not _entities.has(id): return
    var entity = _entities[id]
    _tween.interpolate_property(entity, "position", entity.position, position\
        , 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
    _tween.start()

func _on_entity_died(id: int) -> void:
#    if not _entities.has(id): return
    var entity: Node2D = _entities[id]
    entity.queue_free()
    _entities.erase(id)
    _entities_count -= 1
    _count.text = "Entities: " + str(_entities_count)

func _process(delta: float) -> void:
    if Input.is_action_just_pressed("ui_up"):
        world.spawn_entity()

func _on_timer_timeout():
    _fps.text = "FPS: " + str(Engine.get_frames_per_second())
