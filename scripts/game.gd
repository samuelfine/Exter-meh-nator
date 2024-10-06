extends Node3D


func _ready() -> void:
	SignalBus.game_started.connect(_on_game_started)
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.game_reset.connect(_on_game_reset)


func _on_game_started():
	pass


func _on_game_over():
	pass


func _on_game_reset():
	get_tree().reload_current_scene()
