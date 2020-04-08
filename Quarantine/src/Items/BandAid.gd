extends Area2D

onready var animationPlayer = $AnimationPlayer

var spawnOffset = Vector2(0, -6)

func _ready():
	animationPlayer.play("Spin")


func _on_BandAid_body_entered(_body):
	if _body.name == "Player":
		queue_free()
	else:
		return
