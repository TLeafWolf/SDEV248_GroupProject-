extends StaticBody2D

var rug_speed: Vector2 = Vector2(100, 0)  # Speed of the rug movement
var start_position: Vector2  # Starting position of the rug
var max_distance: float = 300  # Maximum distance the rug will move in one direction
var direction: int = 1  # 1 for right, -1 for left

func _ready():
	# Store the starting position of the rug
	start_position = position

func _process(delta):
	# Move the rug back and forth
	position += rug_speed * delta * direction

	# Check if the rug has reached the maximum distance in one direction
	if abs(position.x - start_position.x) >= max_distance:
		# Reverse the direction when the rug reaches the limit
		direction *= -1
