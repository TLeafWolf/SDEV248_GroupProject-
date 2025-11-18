extends Area2D
#lines that will apear when interecting with NPC
@export var dialogue_lines = [
	"Hello there!",
	"Nice day, isn't it",
	"Take care out there!"
]


var player_in_range = false
var dialogue_index = 0

@onready var label = $Label

func _ready():
	label.visible = false # hide the dialogue label at start
	
func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interaction"):
		show_dialogue()
		

func _on_body_entered(body):
	if body.name == "Player":
		player_in_range = true

func _on_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		label.visible = false
		dialogue_index = 0

func show_dialogue():
	label.visible = true
	label.text = dialogue_lines[dialogue_index]
	dialogue_index += 1
	if dialogue_index >= dialogue_lines.size():
		dialogue_index = 0
		
