extends CanvasLayer

@onready var button = $Button
@onready var panel = $Panel
@onready var player = get_parent().get_node("player")

# Called when the node enters the scene tree for the first time.
func _ready():
	#show cutscene at start
	panel.visible = true
	button.visible = true
	button.pressed.connect(_on_button_pressed)
	
	#disable player movement
	if player:
		player.can_move = false
		
func _on_button_pressed():
	#hide cutscene when button pressed
	panel.visible = false
	button.visible = false
	visible = false
	
	# enable player movement
	if player:
		player.can_move = true
		
