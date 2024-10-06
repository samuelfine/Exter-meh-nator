extends Node3D

# isn't working in time! :(


func _ready() -> void:
	pass
	#get_parent().body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	pass
	#if body.is_in_group("furniture") or body.name == "floor":
		#$AudioStreamPlayer3D.playing = true
