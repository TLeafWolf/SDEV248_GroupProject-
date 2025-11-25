extends CharacterBody2D

@export var speed: float = 250.0
@onready var anim = $AnimatedSprite2D
@onready var area = $Area2D

var is_on_raft: bool = false
var raft_position: Vector2 = Vector2.ZERO
var input_vector: Vector2 = Vector2.ZERO # Declare input_vector outside the function

func _physics_process(delta):
	var new_animation = ""
	input_vector = Vector2.ZERO # Reset input vector at the start of the frame

	# Gather input for movement (arrow keys and WASD)
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
		new_animation = "right"
	elif Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
		new_animation = "left"
	elif Input.is_action_pressed("ui_down"):
		input_vector.y += 1
		new_animation = "down"
	elif Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
		new_animation = "up"

	input_vector = input_vector.normalized() # Normalize to prevent diagonal speed boost

	# Rug detection first half 1 work on here
	detect_raft()


	if is_on_raft:
		if input_vector.length() > 0:
			# Player wants to move, so we allow normal movement and clear the rug state.
			is_on_raft = false
			move_player(input_vector)
		else:
			# If they are on the rug but NOT pressing a key, snap them to the center/position
			position = raft_position
			velocity = Vector2.ZERO # Stop all movement if anchored
	else:
		# Standard movement when not involved with the rug logic
		move_player(input_vector)
# end of rug detection section

	# Handle animation
	handle_animation(new_animation)

func move_player(input_vector: Vector2):
	# This function is now only called when movement is permitted
	velocity = input_vector * speed
	move_and_slide()

func handle_animation(new_animation: String):
	if new_animation != "":
		if anim.animation != new_animation:
			anim.play(new_animation)
	else:
		anim.stop()
# Rug detection first half 2 work on here
func detect_raft():
	is_on_raft= false # Reset each frame
	for body in area.get_overlapping_bodies():
		if body.is_in_group("raft"):
			# Only update the target rug position if we just detected it
			if not is_on_raft:
				raft_position = body.position
			is_on_raft = true
			break # Exit the loop once a rug is found
# end of rug detection section

func _on_goal_body_entered(body: Node2D) -> void:
	pass
