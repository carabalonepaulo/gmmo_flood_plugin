extends Service


const SignInRequest := preload("res://plugins/flood/packets/requests/sign_in.gd")


var client
var tree: SceneTree


func start() -> void:
    .start()
    # tree.change_scene("res://plugins/flood/client/scenes/sign_in/sign_in.tscn")

func process(delta: float) -> void:
    pass

func stop() -> void:
    .stop()

func sign_in(name: String, color: Color) -> void:
    var request := SignInRequest.new()
    request.name = name
    request.color = color
    client.send(request)