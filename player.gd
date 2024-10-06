extends CharacterBody3D

const JUMP_VELOCITY = 5.5

@export var SPEED = 100.0
@export var turn_speed : float = 150.0

var game_started := false

@onready var face = $alive/face

func _ready() -> void:
	SignalBus.game_started.connect(_on_game_started)
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.game_reset.connect(_on_game_reset)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta * 2

	if game_started:
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			$AudioStreamPlayerJump.playing = true

		var turning = Input.get_axis("ui_left", "ui_right")
		var accel = Input.get_axis("ui_down", "ui_up")

		if turning:
			if $AnimationPlayer.current_animation != "run":
				$AnimationPlayer.play("run")
				$AudioStreamPlayer3D.playing = true
			rotate_y(deg_to_rad(-turning * turn_speed * delta))

		if accel:
			if $AnimationPlayer.current_animation != "run":
				$AnimationPlayer.play("run")
				$AudioStreamPlayer3D.playing = true
			velocity.x = face.global_transform.basis.x.x * accel * SPEED * delta
			velocity.z = face.global_transform.basis.x.z * accel * SPEED * delta
		else:
			if !turning:
				$AudioStreamPlayer3D.playing = false
				$AnimationPlayer.play("RESET")
			velocity = velocity.move_toward(Vector3(0, velocity.y, 0), 0.1)
	else:
		velocity.x = 0
		velocity.z = 0
		$AudioStreamPlayer3D.playing = false
		$AnimationPlayer.play("RESET")

	move_and_slide()


func _on_game_started():
	game_started = true
	$alive.visible = true
	$dead.visible = false

func _on_game_over():
	game_started = false
	$alive.visible = false
	$dead.visible = true

func _on_game_reset():
	game_started = false
	$alive.visible = true
	$dead.visible = false
