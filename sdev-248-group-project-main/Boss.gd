extends RigidBody2D

@export var speed = 150.0
@export var path_points = [] # array of vector2 positions
var current_index = 0
var forward = true
@onready var sprite = $AnimatedSprite2D

# player damage variables
@export var damage_cooldown = 1.0 #time in seconds
var last_damge_time = 0.0
var player_in_range: Node2D = null


func _ready():
	sprite.play("Idle")
	set_lock_rotation_enabled(true)
	
func _integrate_forces(state):
	if path_points.size() == 0:
		linear_velocity = Vector2.ZERO
		return
	
	#move towards current target
	var target = path_points[current_index]
	var to_target = target - global_position
	var distance = to_target.length()
	
	if distance < 5:
		#switch to next position based on patrol direction
		if forward:
			current_index += 1
			if current_index >= path_points.size():
				current_index = path_points.size() - 2
				forward = false
		else:
			current_index -= 1
			if current_index < 0:
				current_index = 1
				forward = true
		target = path_points[current_index]
		to_target = target - global_position
	
	var direction = to_target.normalized()
	linear_velocity = direction * speed
	 
	# flip direction of sprite based on movement direction
	if abs(direction.x) > abs(direction.y):
		if direction.x > 0:
			sprite.play("right")
		else:
			sprite.play("left")
	else:
		if direction.y > 0:
			sprite.play("front")
		else:
			sprite.play("back")
	
	#damge the player if they are in range
	if player_in_range:
		var now = Time.get_ticks_msec()
		if now > last_damge_time + int(damage_cooldown * 1000):
			player_in_range.take_damage(1)
			last_damge_time = now


func _on_hitbox_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = body


func _on_hitbox_area_body_exited(body: Node2D) -> void:
	if body == player_in_range:
		player_in_range = null
