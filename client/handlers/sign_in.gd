extends ClientPacketHandler


const SignInResponse := preload("res://plugins/flood/packets/responses/sign_in.gd")


var tree: SceneTree


func _init(): header = 2001

func process(response: SignInResponse) -> void:
    if response.result == OK:
        tree.change_scene("res://plugins/flood/client/scenes/world/world.tscn")
    else:
        tree.current_scene.unlock_controls()
