extends Actor

onready var sprite = $player
onready var animationPlayer = $AnimationPlayer

export var stomp_impulse = 1000.0

var acceleration = 512.0
var max_health = 3
var current_health = max_health
var money = 0

signal health_changed
signal money_changed
signal died


func _on_CollisionDetector_area_entered(_area: Area2D):
	if _area.name == "BandAid":
		if current_health != max_health:
			current_health = current_health + 1
			emit_signal("health_changed", current_health)
	elif _area.name == "Coin":
		money+=1
		print(money)
		emit_signal("money_changed", money)
	else:
		motion = calculate_stomp_velocity(motion, stomp_impulse)


func _on_CollisionDetector_body_entered(_body: PhysicsBody2D):
	if _body.name == "Enemy":
		motion = calculate_knock_back(motion, stomp_impulse)
		take_damage()


func take_damage():
	if current_health > 0:
		current_health -= 1
		emit_signal("health_changed", current_health)
	if current_health == 0:
		emit_signal("died")
		queue_free()
		
		
func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()


func _physics_process(delta):
	var x_input = (Input.get_action_strength("move_right") -
					Input.get_action_strength("move_left"))
	
	if x_input != 0:
		animationPlayer.play("Walk")
		motion.x += x_input * acceleration * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		sprite.flip_h = x_input < 0
	else:
		animationPlayer.play("Stand")
	
	motion.y += GRAVITY * delta
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION)
		
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_FORCE
	else:
		animationPlayer.play("Jump")
		
		if Input.is_action_just_released("jump") && motion.y < -JUMP_FORCE /2.0:
			motion.y = -JUMP_FORCE / 2.0
			
		
		if x_input == 0:
			motion.x = lerp(motion.x, 0, AIR_RESISTANCE)
	
	motion = move_and_slide(motion, Vector2.UP)


func calculate_stomp_velocity(motion: Vector2, impulse: float) -> Vector2:
	var out: = motion
	out.y = -impulse
	return out


func calculate_knock_back(motion: Vector2, impulse: float) -> Vector2:
	var out: = motion
	if sprite.flip_h:
		out.x = impulse
	else:
		out.x = -impulse
	return out

