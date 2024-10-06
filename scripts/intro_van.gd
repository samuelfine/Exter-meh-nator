extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.game_started.connect(_on_game_started)
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.game_reset.connect(_on_game_reset)


func _on_game_started():
	await get_tree().create_timer(3).timeout
	visible = false


func _on_game_over():
	pass


func _on_game_reset():
	visible = true
