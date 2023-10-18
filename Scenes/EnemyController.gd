extends CharacterBody2D


# Entity parameters.
@export var _speed = 5.0;
@export var _game_level = 1;

# Components and nodes.
@onready var active_zone = $'../ActivationZone'
@onready var deactive_zone = $'../DeactivationZone'
@onready var ball = $'../Ball'

# Internal variables.
var direction = 0; # -1 is upwards, 1 is downwards.
var active = false;


func _ready():
	# Start the enemy in the middle of the screen vertically
	# and 19/20ths of the way to the right edge.
	position.x = get_viewport_rect().size.x/20 * 19;
	position.y = get_viewport_rect().size.y/2;


func _physics_process(delta):
	if (active): # Only move if active.
		MovementHandler()
		move_and_collide(velocity)
	

func MovementHandler():
	# If the ball is above the paddle, move up.
	if (ball.position.y - position.y > 0):
		direction = 1
	else:
		direction = -1
	
	velocity.y = direction * _speed * _game_level;
	

# Activates the enemy if the ball exits the activation zone to the right.
func _on_enemy_activation_zone_body_exited(body):
	if ("Ball" in body.name):
		if (body.position.x > active_zone.position.x):
			active = true


# Deactivates the enemy if the ball exits the deactovation zone to the left.
func _on_deactivation_zone_body_exited(body):
	if ("Ball" in body.name):
		if (body.position.x < deactive_zone.position.x):
			print("deactivated")
			active = false

# Activate the enemy on ball reset so it starts the round active.
func _on_ball_ball_reset():
	active = true
