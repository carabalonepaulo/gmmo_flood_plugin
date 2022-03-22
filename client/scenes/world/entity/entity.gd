tool
extends Node2D


export var size: float = 5
export var color: Color = Color.white
export var interval: float


func _ready():
    pass

func _draw() -> void:
    draw_circle(Vector2.ZERO, size, color)
