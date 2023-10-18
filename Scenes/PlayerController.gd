extends CharacterBody2D


# Entity parameters.
@export var _speed = 5.0;


# Internal variables.
var direction = 0; # -1 is upwards, 1 is downwards.


func _ready():
	# Start the player in the middle of the screen vertically
	# and 1/20ths of the way to the right edge.
	position.x = get_viewport_rect().size.x/20 * 1;
	position.y = get_viewport_rect().size.y/2;


func _physics_process(delta):
	MovementHandler()
	move_and_collide(velocity)
	

func MovementHandler():
	direction = Input.get_axis("move_up", "move_down")
	velocity.y = direction * _speed;
