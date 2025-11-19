extends CanvasLayer

@onready var button = $Button
@onready var panel = $Panel
@onready var player = get_parent().get_node("player")

func show_victory():
	#show victory screen and disable the player movement
	panel.visible = true
	button.visible = true
	visible = true
	if player:
		player.can_move = false
		
	button.pressed.connect(_on_button_pressed)
	
func _on_button_pressed():
	# hide victory screen and restart level
	panel.visible = false
	button.visible = false
	visible = false
	
	if player:
		player.can_move = true
	#restart the level
	get_tree().reload_current_scene()
	


func _on_goal_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		show_victory()
