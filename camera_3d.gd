extends Camera3D

@export var player : CharacterBody3D
@export var swat_zone : Area3D

var swat_timer = 2
var game_started := false
var move_speed := 0.6
var speed_increase_timer := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.game_started.connect(_on_game_started)
	SignalBus.game_over.connect(_on_game_over)
	SignalBus.game_reset.connect(_on_game_reset)


func _anim_check():
	if !game_started:
		$AnimationPlayer.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_started:
		speed_increase_timer += delta
		if speed_increase_timer >= 5:
			speed_increase_timer = 0
			move_speed = min(move_speed + 0.06, 1.05)

		var xform := transform # your transform
		xform = xform.looking_at(player.global_position,Vector3.UP)
		transform = transform.interpolate_with(xform, (move_speed + 0.1) * delta)
		position = position.move_toward(Vector3(player.global_position.x + 0.1, global_position.y, player.global_position.z + 0.1), move_speed * delta)
		$SwatSpot.global_position.y = 0

		swat_timer -= delta
		if swat_timer <= 0:
			swat_timer = 2


func _whiff():
	$AudioStreamPlayerWhiff.playing = true


func _swat():
	var cols = swat_zone.get_overlapping_bodies()
	for col in cols:
		if col.is_in_group("furniture"):
			$AudioStreamPlayer3D.playing = true
			col.apply_impulse(Vector3(transform.basis.z.x, 0, transform.basis.z.z) * -15, Vector3(0, 0.5, 0))
		if col.name == "Bugg":
			SignalBus.game_over.emit()
			$AudioStreamPlayer3D.playing = true


func _on_game_started():
	$AnimationPlayer.play("swatter_bob")
	$AudioStreamWalking.playing = true
	game_started = true
	$swatter.visible = true
	$Decal.visible = true
	move_speed = 0.6
	#$Decal.visible = true
	speed_increase_timer = 0.0


func _on_game_over():
	$AudioStreamWalking.playing = false
	game_started = false


func _on_game_reset():
	$AudioStreamWalking.playing = false
	game_started = false
	$swatter.visible = false
	$Decal.visible = false
