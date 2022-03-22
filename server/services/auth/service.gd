extends Service


signal signed_in(cid, name, color)
signal signed_out(cid, name)


const SignInRequest := preload("res://plugins/flood/packets/requests/sign_in.gd")


var listener: ListenerService
var _clients: Dictionary
var _online_now: Array


func start() -> void:
    .start()
    _clients = {}
    _online_now = []

    listener.connect("client_disconnected", self, "_on_client_disconnected")

func _on_client_disconnected(cid: int) -> void:
    if is_signed_in(cid): sign_out(cid)

func stop() -> void:
    .stop()
    _clients.clear()
    _online_now.clear()

func is_signed_in(cid: int) -> bool:
    return _clients.has(cid)

func is_online_now(name: String) -> bool:
    return _online_now.has(name)

func sign_in(cid: int, name: String, color: Color) -> void:
    _clients[cid] = { name = name, color = color }
    _online_now.push_back(name)
    emit_signal("signed_in", cid, name, color)
    logger.write_line("debug", "User %s signed in." % name)

func sign_out(cid: int) -> void:
    var user = _clients[cid]
    emit_signal("signed_out", cid, user.name)
    logger.write_line("debug", "User %s signed in." % user.name)
    _clients.erase(cid)
    _online_now.erase(user.name)