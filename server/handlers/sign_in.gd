extends ServerPacketHandler


const AuthService := preload("res://plugins/flood/server/services/auth/service.gd")
const SignInRequest := preload("res://plugins/flood/packets/requests/sign_in.gd")
const SignInResponse := preload("res://plugins/flood/packets/responses/sign_in.gd")


var auth: AuthService


func _init(): header = 2000

func can_process() -> bool:
    return not auth.is_signed_in(sender_id)

func process(request: SignInRequest) -> void:
    var response := SignInResponse.new()
    response.result = FAILED if auth.is_online_now(request.name) else OK
    reply(response)