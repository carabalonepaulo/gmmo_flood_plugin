extends Control


const AuthService := preload("res://plugins/flood/client/services/auth/service.gd")


onready var main = get_tree().root.get_node("main")
onready var auth: AuthService = main.services.auth

onready var _name: LineEdit = $c1/c1/c1/c1/r1/r1/c2/name
onready var _sign_in: Button = $c1/c1/c1/c1/r2/sign_in


func _ready():
    _name.grab_focus()

func unlock_controls() -> void:
    _name.editable = true
    _sign_in.disabled = false

func lock_controls() -> void:
    _name.editable = false
    _sign_in.disabled = true

func _on_sign_in_pressed():
    if _name.text.length() < 5: return
    auth.sign_in(_name.text)
    lock_controls()
