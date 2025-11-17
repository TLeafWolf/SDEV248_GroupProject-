extends Camera2D

@export var player_path: NodePath
var player: Node2D

#Distance the camera moves when the player reaches the edge
var move_distance:= Vector2.ZERO

func _ready():
	player = get_node(player_path)
	set_as_top_level(true)
	
	#calculate how much the camera should move in world units
	move_distance = Vector2(1152, 648) / zoom
	
func _physics_process(delta):
	var player_pos = player.global_position
	var cam_pos = global_position
	
	var new_cam_pos = global_position
	
	#check horizontal edges
	if player_pos.x <= cam_pos.x - move_distance.x / 2:
		new_cam_pos.x -= move_distance.x
	elif player_pos.x >= cam_pos.x + move_distance.x / 2:
		new_cam_pos.x += move_distance.x
	
	#check vertical edges
	if player_pos.y <= cam_pos.y - move_distance.y / 2:
		new_cam_pos.y -= move_distance.y
	elif player_pos.y >= cam_pos.y + move_distance.y / 2:
		new_cam_pos.y += move_distance.y
		
	#move the camera by the fixed distance
	if new_cam_pos != cam_pos:
		global_position = new_cam_pos
		
