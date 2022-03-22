extends Service


var tree: SceneTree
var _elapsed: float
var _last_frame: int


func start() -> void:
    .start()

func process(delta: float) -> void:
    _elapsed += delta
    if _elapsed >= 1:
        var now := OS.get_ticks_msec()
        print("FPS: ", str(Engine.get_frames_per_second()))
        print("Since last frame: " + str(now - _last_frame))
        _last_frame = now
        _elapsed = 0