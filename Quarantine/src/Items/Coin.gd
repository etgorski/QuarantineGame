extends Area2D

onready var animationPlayer = $AnimationPlayer


func _ready():
	animationPlayer.play("CoinSpin")


func _on_Coin_body_entered(_body):
	if _body.name == "Player":
		queue_free()
	else:
		return
