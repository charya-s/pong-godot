extends CanvasLayer

# Entity paramters.
@export var _victory_score = 5

# Components and nodes.
@onready var score = $Score
@onready var result_box = $ResultBox

# Internal variables.
var player_score = 0
var enemy_score = 0

func _ready():
	# Set size of text boxes to be entire width of screen.
	score.size.x = get_tree().get_root().size.x
	result_box.position.x = get_tree().get_root().size.x/2
	score.visible = true
	result_box.visible = false # Result box is not visible until the game ends.
	
func _process(delta):
	score.text = str("[center][b][font_size=40] ", player_score, " - ", enemy_score)
	if (player_score == _victory_score):
		HandleWin()
	if (enemy_score == _victory_score):
		HandleLoss()


func _on_ball_enemy_scores():
	if (enemy_score < _victory_score):
		enemy_score += 1

func _on_ball_player_scores():
	if (player_score < _victory_score):
		player_score += 1
	
func HandleWin():
	get_tree().paused = true
	result_box.visible = true
	score.visible = false
	result_box.get_child(0).text = str("[center][b][font_size=40]You win!\n", player_score, " - ", enemy_score)
		
func HandleLoss():
	get_tree().paused = true
	result_box.visible = true
	score.visible = false
	result_box.get_child(0).text = str("[center][b][font_size=40]Enemy wins!\n", player_score, " - ", enemy_score)
