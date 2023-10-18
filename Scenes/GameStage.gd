extends Node2D

# Entity parameters.
const _max_level = 5 # Maximum difficulty level.
@export var _game_level = 1 # Current difficulty level.

# Components and nodes.
@onready var active_zone = $ActivationZone
@onready var deactive_zone = $DeactivationZone

func _ready():
	active_zone.position.y = get_viewport_rect().size.y/2;
	deactive_zone.position.y = get_viewport_rect().size.y/2;
	# The zone the ball has to be in for the enemy to start moving. 
	# The position depends on the game level (enemy reacts slower at lower levels).
	active_zone.position.x = get_viewport_rect().size.y/10 * (_max_level - _game_level);
