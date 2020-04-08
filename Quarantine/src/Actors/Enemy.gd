extends Actor

onready var animationPlayer = $AnimationPlayer

var acceleration = 300.0
var bandaid_scene = preload("res://src/Items/BandAid.tscn")

signal death


func _ready() -> void:
	set_physics_process(false)


func _on_Enemy_death():
	var bandaid = bandaid_scene.instance()
	bandaid.set_position(global_position + bandaid.spawnOffset)
	get_parent().call_deferred("add_child", bandaid)


func _on_StompDetector_body_entered(_body: PhysicsBody2D):
	emit_signal("death")
	queue_free()


func _physics_process(delta):
	motion.y += GRAVITY * delta
	
	if is_on_floor():
		animationPlayer.play("Moving")
		motion.x += direction.x * acceleration * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	else:
		animationPlayer.play("Still")
	
	motion = move_and_slide(motion, Vector2.UP)
	
	if is_on_wall():
		if direction == right:
			direction = left
		elif direction == left:
			direction = right
