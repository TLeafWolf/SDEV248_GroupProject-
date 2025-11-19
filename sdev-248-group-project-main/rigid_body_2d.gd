extends RigidBody2D

@export var speed: float = 150.0
@onready var anim = $AnimatedSprite2D

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	var new_animation = ""
	
	if Input.is_action_pressed("right"):
		input_vector.x += 1
		new_animation = "right"
	elif Input.is_action_pressed("left"):
		input_vector.x -= 1
		new_animation = "left"
	elif Input.is_action_pressed("down"):
		input_vector.y += 1
		new_animation = "down"
	elif Input.is_action_pressed("up"):
		input_vector.y -= 1
		new_animation = "up"

	input_vector = input_vector.normalized()
	linear_velocity = input_vector * speed
	
	# play the animation if its different than the current
	if new_animation != "":
		if anim.animation != new_animation:
			anim.play(new_animation)
	else:
		anim.stop()


func _on_goal_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
