extends Node3D

enum STATES {INTRO, STARTED, OVER}
var game_state = STATES.INTRO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.game_over.connect(_on_game_over)


func _on_game_over():
	game_state = STATES.OVER


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			if game_state == STATES.INTRO:
				game_state = STATES.STARTED
				SignalBus.game_started.emit()
			if game_state == STATES.OVER:
				game_state = STATES.INTRO
				SignalBus.game_reset.emit()
